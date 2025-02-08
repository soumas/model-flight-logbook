import functools
import re
import time
import selenium
import traceback
from datetime import datetime, timedelta
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import StaleElementReferenceException, NoSuchElementException

from config.configmanager import config
from db.entities import PilotEntity
from utils.logger import log
from utils.send_mail import send_mail
from db.dbmanager import SessionLocal


DEFAULT_WAIT_TIME_SECONDS = 30
DATETIME_FORMAT = '%d.%m.%Y %H:%M'
DATETIME_FORMAT_WITH_SECONDS = '%d.%m.%Y %H:%M:%S'
BASEURL = 'https://utm.dronespace.at/avm/#p=5/47.74/13.23'
UTM_FLIGHTPLAN_DURATION_MINUTES = 4 * 60

def __create_driver():
    log.debug('__create_driver')
    service = Service(config.logbook.chromedriver_path)
    options = Options()
    options.add_argument("--lang=de-DE");
    options.add_argument("--headless")
    driver = webdriver.Chrome(service=service, options=options)
    driver.set_window_size(1920,1080)
    return driver

def __dispose_driver(driver):
    log.debug('__dispose_driver')
    if driver != None:
        driver.quit()

def __utm_save_error_screenshot(driver, methodname:str):
    if driver != None:
        try:
            utmerrorpath = './utm_error_screenshots/'
            Path(utmerrorpath).mkdir(parents=True, exist_ok=True)
            errorimgpath = utmerrorpath + datetime.now().strftime('%Y%m%d%H%M%S') + '_' + methodname +  '.png'
            driver.save_screenshot(errorimgpath)
            return errorimgpath
        except:
            log.error('Error on saving screenshot for error in method ' + methodname)
            log.error(traceback.format_exc())


def __run_with_retry(func, *args):
    errcnt = 0;
    while True:
        try:
            if(len(args) == 0):
                return func()
            elif(len(args) == 1):
                return func(args[0])
            elif(len(args) == 2):
                return func(args[0],args[1])
            elif (len(args) == 3):
                return func(args[0],args[1],args[2])
            elif(len(args) == 4):
                return func(args[0],args[1],args[2],args[3])
            elif(len(args) == 5):
                return func(args[0],args[1],args[2],args[3], args[4])
            else:
                raise 'too much arguments - not supported'
        except StaleElementReferenceException:
            if errcnt >= 2:
                raise
            errcnt = errcnt+1

def __wait_until_url_loaded(driver, url, timeout=DEFAULT_WAIT_TIME_SECONDS):
    log.debug('__wait_until_url_loaded, url {}, timeout {}'.format(url, timeout))
    WebDriverWait(driver, timeout).until(EC.url_matches(url))

def __wait_until_clickable(driver, xpath, timeout=DEFAULT_WAIT_TIME_SECONDS):
    log.debug('__wait_until_clickable, xpath {}, timeout {}'.format(xpath, timeout))
    __run_with_retry(
        lambda driver, xpath, timeout: WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath))),
        driver,xpath,timeout
    )

def __wait_and_click(driver, xpath, timeout=DEFAULT_WAIT_TIME_SECONDS):
    log.debug('__wait_and_click, xpath {}, timeout {}'.format(xpath, timeout))
    __wait_until_clickable(driver, xpath, timeout)
    __run_with_retry(
        lambda driver, xpath: driver.find_element(By.XPATH, xpath).click(),
        driver, xpath
    )

def __wait_and_send_key(driver, xpath, text, timeout=DEFAULT_WAIT_TIME_SECONDS):
    log.debug('__wait_and_send_key, xpath {}, text ***, timeout {}'.format(xpath, timeout))
    __wait_until_clickable(driver, xpath, timeout)
    __run_with_retry(
        lambda driver, xpath:driver.find_element(By.XPATH, xpath).send_keys(Keys.CONTROL + "a"),
        driver, xpath)
    __run_with_retry(
        lambda driver, xpath:driver.find_element(By.XPATH, xpath).send_keys(Keys.DELETE),
        driver,xpath)
    __run_with_retry(
        lambda driver, xpath:driver.find_element(By.XPATH, xpath).send_keys(text),
        driver,xpath)

def __check_if_exists(driver, xpath):
    try:
        driver.find_element(By.XPATH, xpath)
        return True
    except NoSuchElementException:
        return False

def __utm_login(driver):    
    log.debug('__utm_login')

    driver.get(BASEURL)

    log.debug('accept terms and conditions')
    __wait_and_click(driver, "//*[@class='button ok']") # agb akzeptieren
    
    log.debug('handle login form')
    __wait_and_click(driver, "//a[normalize-space()='Sign in / Sign up']")
    __wait_until_url_loaded(driver, 'https://utm.dronespace.at/keycloak2/*')
    __wait_and_send_key(driver, "//input[@id='username']", config.utm.username)
    __wait_and_send_key(driver, "//input[@id='password']", config.utm.password)
    __wait_and_click(driver, "//button[@type='submit']")
    __wait_until_url_loaded(driver, 'https://utm.dronespace.at/avm/')
    __wait_until_clickable(driver, "//a[normalize-space()='Sign out']")


def __utm_open_menu(driver, menutag):
    log.debug('__utm_open_menu')    
    driver.get(BASEURL+'&menu='+menutag)
    driver.refresh()

def __build_flightplan_name(airportname:str, pilotid:str):
    log.debug('__build_flightplan_name')
    return '{} ({})'.format(airportname, pilotid)

def __find_all_active_flight_plan_xpaths(driver, airportname:str):
    log.debug('__login_and_find_all_active_flight_plan_xpaths')            
    __utm_open_menu(driver,'operationplans')
    # Wait until "closed flight plans" are loaded becaues that means that active flight plans (if any) are loaded too.
    # # If this is a very new UTM account without any closed flight plans, this request will fall into the timeout exception.
    try:
        __wait_until_clickable(driver, "(//div[@class='logs']/div[@class='log'])[1]")
    except selenium.common.exceptions.TimeoutException:
        log.debug('Could not find any closed flight plan. Assuming that this is a very new UTM account and going on...')
    xpaths = []
    for i in range(1,100):
        xpath = "(//div[@class='operation-plans']/div[@class='operation-plan']/p[@class='name' and starts-with(normalize-space(.),'" + airportname + "')])[" + str(i) + "]/parent::*"
        if __check_if_exists(driver, xpath):
            xpaths.append(xpath)
        else:
            break
    return xpaths

def __close_active_flightplans(driver, airportname:str, pilotToIgnore:PilotEntity | None):
    activeFlightPlanXPaths = __find_all_active_flight_plan_xpaths(driver, airportname)
    for xpath in reversed(activeFlightPlanXPaths):
        
        flightname = __read_flightname_from_dom(driver=driver, xpath=xpath)
        pilotid = __extract_pilotid_from_flightname(airportname=airportname, flightname=flightname)
        
        doClose = True
        if pilotToIgnore != None and pilotid == pilotToIgnore.id and __read_flightplan_is_active_from_dom(driver=driver, xpath=xpath):
            doClose = False

        if doClose:
            utmStartTime = __read_startdate_from_dom(driver, xpath=xpath)
            utmEndTime = utmStartTime + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES)
            __wait_and_click(driver, xpath)
            __wait_and_click(driver, "//button[normalize-space()='End flight']")
            pilot = __findPilot(pilotid=pilotid)         
            send_mail(
                to=pilot.email, 
                bcc=config.logbook.admin_email, 
                subject='Flugplan beendet (' + airportname + ', ' + utmStartTime.strftime('%H:%M') + ' - ' + utmEndTime.strftime('%H:%M') + ')',
                body='Hallo ' + pilot.firstname + ' ' + pilot.lastname + '!<br/><br/>Folgender Flugplan wurde bei der Luftfahrtbehörde beendet:<br/><ul><li>' + flightname + '</li><li>Beginn: ' + utmStartTime.strftime('%d.%m.%Y, %H:%M') + ' Uhr</li><li>Ende: ' + utmEndTime.strftime('%d.%m.%Y, %H:%M') + ' Uhr</li><li>Operator: ' + pilot.firstname + ' ' + pilot.lastname + '</li></ul><br/>Model Flight Logbook')
                        

def __pilot_has_active_flight(driver, airportname:str, pilotid:str):
    activeFlightPlanXPaths = __find_all_active_flight_plan_xpaths(driver, airportname)
    for xpath in activeFlightPlanXPaths:
        flightname = __read_flightname_from_dom(driver=driver, xpath=xpath)
        utmpilotid = __extract_pilotid_from_flightname(airportname=airportname, flightname=flightname)        
        if pilotid == utmpilotid and __read_flightplan_is_active_from_dom(driver=driver, xpath=xpath):
            return True
    return False

def __read_flightplan_is_active_from_dom(driver, xpath:str):
    utmStartTime = __read_startdate_from_dom(driver, xpath=xpath)
    utmEndTime = utmStartTime + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES)
    return datetime.now() < utmEndTime

def __read_flightname_from_dom(driver, xpath:str):
    __wait_until_clickable(driver, xpath)
    return driver.find_element(By.XPATH, xpath+"/p[@class='name']").text

def __read_startdate_from_dom(driver, xpath:str):
    __wait_until_clickable(driver, xpath)
    datestring = driver.find_element(By.XPATH, xpath+"/p[@class='meta']/span[2]").text
    dateregex = r"^(?P<day>\d{1,2})\.(?P<month>\d{1,2})\.(?P<year>\d{4})$"
    datematches = re.search(dateregex, datestring)

    timestring = driver.find_element(By.XPATH, xpath+"/p[@class='meta']/span[3]").text
    timeregex = r"^(?P<hour>\d{1,2}):(?P<minute>\d{1,2})-"
    timematches = re.search(timeregex, timestring)

    return datetime(year=int(datematches['year']), month=int(datematches['month']), day=int(datematches['day']), hour=int(timematches['hour']), minute=int(timematches['minute']))

def __extract_pilotid_from_flightname(airportname:str, flightname:str):
    regexstr = r"^" + airportname + " \((?P<pilotid>\d+)\)$"
    matches = re.search(regexstr, flightname)
    if matches != None:
        return matches['pilotid']
    return None

def update_utm_operator(airportname:str, airportkml:str, pilot:PilotEntity | None):

    driver = None
    error = None
    try:        
        driver = __create_driver()
        __utm_login(driver)

        doCreateNewFlightplan = pilot != None and not __pilot_has_active_flight(driver, airportname, pilot.id)

        if(doCreateNewFlightplan):
            __wait_and_click(driver, "//i[@class='ti ti-arrow-left']") #back to main menu
            __wait_and_click(driver, "//i[@class='ti ti-x']") # close menu
            __wait_and_click(driver, "//i[@class='ti ti-drone']")
            __wait_until_clickable(driver, "//i[@class='ti ti-arrow-right']") # await menu animation
            driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys(airportkml)
            __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
            __wait_and_send_key(driver, "//label[normalize-space()='First name *']/following-sibling::input", pilot.firstname)
            __wait_and_send_key(driver, "//label[normalize-space()='Last name *']/following-sibling::input", pilot.lastname)
            __wait_and_send_key(driver, "//label[normalize-space()='Phone number *']/following-sibling::input", re.sub("[^\+0-9]", "", pilot.phonenumber))
            __wait_and_send_key(driver, "//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input", config.utm.mtom_g)
            __wait_and_send_key(driver, "//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input",config.utm.max_altitude_m)
            __wait_and_send_key(driver, "//label[normalize-space()='Public title of your flight']/following-sibling::input", __build_flightplan_name(airportname, pilot.id))
            utmStartTime = datetime.now().replace(second=0, microsecond=0) + timedelta(minutes=2)
            utmEndTime = utmStartTime + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES)
            __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", (utmStartTime + timedelta(minutes=30)).strftime(DATETIME_FORMAT)) # first set end date to half an hour after startdate to avoid alert 'flight time too short'
            __wait_and_click(driver, "//label[normalize-space()='Phone number *']/following-sibling::input") # close calendar control by clicking into another field
            __wait_and_send_key(driver, "//label[normalize-space()='Start date and time *']/following-sibling::div/input", utmStartTime.strftime(DATETIME_FORMAT)) # now we can set the starttime without alert
            __wait_and_click(driver, "//label[normalize-space()='Phone number *']/following-sibling::input") # close calendar control by clicking into another field
            __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", utmEndTime.strftime(DATETIME_FORMAT))
            __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
            __wait_and_click(driver, "//i[@class='ti ti-send']")
            __wait_and_click(driver, "//div[@class='waiting-plans']/div[@class='operation-plan']/div[@class='status APPROVED']/following-sibling::p[contains(normalize-space(.), '" + __build_flightplan_name(airportname,pilot.id) + "')]", 300)
            secondsBeforeStartTime = (utmStartTime - datetime.now()).total_seconds() + 10 # 10 seconds buffer to be sure that start time is arrived
            if(secondsBeforeStartTime>0):
                log.debug('waiting ' + str(secondsBeforeStartTime) + 'seconds for start time')
                time.sleep(secondsBeforeStartTime)
            __wait_and_click(driver, "//button[normalize-space()='Activate flight plan']")
            __wait_until_clickable(driver, "//button[normalize-space()='End flight']", timeout=300)            
            send_mail(
                to=pilot.email, 
                bcc=config.logbook.admin_email, 
                subject='Flugplan aktiviert (' + airportname + ', ' + utmStartTime.strftime('%H:%M') + ' - ' + utmEndTime.strftime('%H:%M') + ')', 
                body='Hallo ' + pilot.firstname + ' ' + pilot.lastname + '!<br/><br/>Folgender Flugplan wurde bei der Luftfahrtbehörde aktiviert. Bis zur Beendigung ist die persönliche Anwesenheit und die telefonische Erreichbarkeit unter <strong>' + pilot.phonenumber + '</strong> erforderlich.<br/><ul><li>' + __build_flightplan_name(airportname, pilot.id) + '</li><li>Beginn: ' + utmStartTime.strftime('%d.%m.%Y, %H:%M') + ' Uhr</li><li>Ende: ' + utmEndTime.strftime('%d.%m.%Y, %H:%M') + ' Uhr</li><li>Operator: ' + pilot.firstname + ' ' + pilot.lastname + '</li></ul><br/><strong>Wichtig!</strong> Der Flugtag muss vor dem Verlassen des Flugplatzes am MFL Terminal beendet werden, wodurch auch die Abmeldung bei der Luftfahrtbehörde erfolgt.<br/><br/>Model Flight Logbook')
            
        __close_active_flightplans(driver, airportname, None if pilot is None else pilot)

        # TODO: do fianl check if state is as desired
        return False if pilot is None else True

    except:
        error = traceback.format_exc()
        log.error(error)
        screenshotpath = __utm_save_error_screenshot(driver=driver, methodname='update_utm_operator')
        send_mail(to=config.logbook.admin_email, subject='UTM Interaktion fehlgeschlagen', body='Flugplatz: ' + airportname + '<br/>Fehler:<br/>' + error, attachmentpath=screenshotpath)
        raise
    finally:        
        __dispose_driver(driver)

def __findPilot(pilotid:str):
    db = SessionLocal()
    try:
        return db.query(PilotEntity).filter(PilotEntity.id == pilotid).first()
    except:
        db.rollback()
        raise
    finally:
        db.close()
