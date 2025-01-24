import re
import time
import selenium
import traceback
from datetime import datetime, timedelta
from pathlib import Path
from fastapi import BackgroundTasks
from selenium import webdriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import StaleElementReferenceException

from config.configmanager import TerminalConfig, config
from db.entities import PilotEntity
from utils.logger import log
from utils.send_mail import send_admin_notification

 
DEFAULT_WAIT_TIME = 30
DATETIME_FORMAT = '%d.%m.%Y %H:%M'
DATETIME_FORMAT_WITH_SECONDS = '%d.%m.%Y %H:%M:%S'

def __create_driver():
    log.debug('__create_driver')

    service = Service(config.logbook.chromedriver_path)

    options = Options()
    options.add_argument("--headless")

    driver = webdriver.Chrome(service=service, options=options)
    driver.set_window_size(1920,1080)
    return driver

def __dispose_driver(driver):
    log.debug('__dispose_driver')
    if driver != None:
        driver.close()

def __utm_save_error_screenshot(driver, methodname:str):
    if driver != None:
        try:
            utmerrorpath = './utm_error_screenshots/'
            Path(utmerrorpath).mkdir(parents=True, exist_ok=True)
            driver.save_screenshot(utmerrorpath + datetime.now().strftime('%Y%m%d%H%M%S') + '_' + methodname +  '.png')
        except:
            log.error('Error on saving screenshot for error in method ' + methodname)
            log.error(traceback.format_exc())

def __wait_until_url_loaded(driver, url, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_until_url_loaded, url {}, timeout {}'.format(url, timeout))
    WebDriverWait(driver, timeout).until(EC.url_matches(url))

def __wait_until_clickable(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_until_clickable, xpath {}, timeout {}'.format(xpath, timeout))
    errcnt = 0;
    while True:
        try:
            WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
            return
        except StaleElementReferenceException:
            if errcnt >= 5:
                raise
            errcnt = errcnt+1

def __wait_and_click(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_and_click, xpath {}, timeout {}'.format(xpath, timeout))
    __wait_until_clickable(driver, xpath, timeout)
    driver.find_element(By.XPATH, xpath).click()

def __wait_and_send_key(driver, xpath, text, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_and_send_key, xpath {}, text ***, timeout {}'.format(xpath, timeout))
    __wait_until_clickable(driver, xpath, timeout)
    driver.find_element(By.XPATH, xpath).send_keys(Keys.CONTROL + "a")
    driver.find_element(By.XPATH, xpath).send_keys(Keys.DELETE)
    driver.find_element(By.XPATH, xpath).send_keys(text)

def __utm_login(driver):    
    log.debug('__utm_login')

    driver.get('https://utm.dronespace.at/avm/#p=5/47.74/13.23')

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


def __utm_open_menu(driver):
    log.debug('__utm_open_menu')
    # workaround for the buggy menu button
    for i in range(2):
        try:
            __wait_and_click(driver, "//div[@id='menu-button']")
            time.sleep(1)
            __wait_until_clickable(driver, "//span[normalize-space()='Flight plans and log']")
        except:
            log.debug('bugy menu fallback')
            pass

def __build_flightplan_name(terminal:TerminalConfig):
    log.debug('__build_flightplan_name')
    return '{} ({})'.format(terminal.airportname, terminal.terminalname)

def close_active_flightplan(terminal:TerminalConfig):
    driver = None
    error = None
    try:
        driver = __create_driver()
        __utm_login(driver)
        __utm_open_menu(driver)
        __wait_and_click(driver, "//span[normalize-space()='Flight plans and log']")
        try:
            __wait_and_click(driver, "//div[@class='operation-plans']/div[@class='operation-plan']/div[@class='status ACTIVATED']/following-sibling::p[contains(normalize-space(.), '" + __build_flightplan_name(terminal=terminal) + "')]", timeout=5)
        except selenium.common.exceptions.TimeoutException:
            log.debug('No active Flight with name ' + __build_flightplan_name(terminal=terminal) + ' found')
            return
        __wait_and_click(driver, "//button[normalize-space()='End flight']")
    except:
        error = traceback.format_exc()
        log.error(error)
        __utm_save_error_screenshot(driver=driver, methodname='create_and_activate_flightplan')
        __send_error_notification(error=error)
        raise
    finally:        
        __dispose_driver(driver)


def start_flightplan(terminal:TerminalConfig, pilot:PilotEntity ):
    driver = None
    error = None
    try:
        driver = __create_driver()
        __utm_login(driver)
        __wait_and_click(driver, "//i[@class='ti ti-drone']")
        __wait_until_clickable(driver, "//i[@class='ti ti-arrow-right']") # await menu animation
        driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys(terminal.airportkml)
        __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
        __wait_and_send_key(driver, "//label[normalize-space()='First name *']/following-sibling::input", pilot.firstname)
        __wait_and_send_key(driver, "//label[normalize-space()='Last name *']/following-sibling::input", pilot.lastname)
        __wait_and_send_key(driver, "//label[normalize-space()='Phone number *']/following-sibling::input", re.sub("[^0-9]", "", pilot.phonenumber))
        __wait_and_send_key(driver, "//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input", config.utm.mtom_g)
        __wait_and_send_key(driver, "//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input",config.utm.max_altitude_m)
        __wait_and_send_key(driver, "//label[normalize-space()='Public title of your flight']/following-sibling::input", __build_flightplan_name(terminal=terminal))
        utmStartTime = datetime.now().replace(second=0, microsecond=0) + timedelta(minutes=2)
        utmEndTime = utmStartTime + timedelta(hours=4, minutes=0)
        __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", (utmStartTime + timedelta(minutes=30)).strftime(DATETIME_FORMAT)) # first set end date to half an hour after startdate to avoid alert 'flight time too short'
        __wait_and_click(driver, "//label[normalize-space()='Phone number *']/following-sibling::input") # close calendar control by clicking into another field
        __wait_and_send_key(driver, "//label[normalize-space()='Start date and time *']/following-sibling::div/input", utmStartTime.strftime(DATETIME_FORMAT)) # now we can set the starttime without alert
        __wait_and_click(driver, "//label[normalize-space()='Phone number *']/following-sibling::input") # close calendar control by clicking into another field
        __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", utmEndTime.strftime(DATETIME_FORMAT))
        __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
        __wait_and_click(driver, "//i[@class='ti ti-send']")
        __wait_and_click(driver, "//div[@class='waiting-plans']/div[@class='operation-plan']/div[@class='status APPROVED']/following-sibling::p[contains(normalize-space(.), '" + __build_flightplan_name(terminal=terminal) + "')]", 300)
        secondsBeforeStartTime = (utmStartTime - datetime.now()).total_seconds() + 10 # 10 seconds buffer to be sure that start time is arrived
        if(secondsBeforeStartTime>0):
            log.debug('waiting ' + str(secondsBeforeStartTime) + 'seconds for start time')
            time.sleep(secondsBeforeStartTime)
        __wait_and_click(driver, "//button[normalize-space()='Activate flight plan']")
        __wait_until_clickable(driver, "//button[normalize-space()='End flight']", timeout=300)
    except:
        error = traceback.format_exc()
        log.error(error)
        __utm_save_error_screenshot(driver=driver, methodname='start_flightplan')
        __send_error_notification(error=error)
        raise
    finally:        
        __dispose_driver(driver)


def __send_error_notification(terminal:TerminalConfig, error: str): 
    # notify admin in case of an error
    try:
        send_admin_notification(
            subject="UTM Interaktion fehlgeschlagen!",
            body={'message':'Bei einer Interaktion mit dem UTM System bzgl. dem Flugplan <b>"' + __build_flightplan_name(terminal=terminal) + '"</b> ist folgender Fehler aufgetreten:<br/><br/>' + error }
        )
    except:
        # don't throw exception when notification fails
        log.error(traceback.format_exc())



# def __send_notification(background_tasks: BackgroundTasks, pilot: PilotEntity, fsession:FlightSessionEntity, terminal:TerminalConfig, error: str):    
#     log.debug('__send_notification ({})'.format(pilot.id))

#     # notify pilot
#     try:
#         if config.utm.notify_pilot:
#             send_mail(
#                 background_tasks=background_tasks,
#                 template_name="pilot_utm_status.html",
#                 email_to=pilot.email,
#                 subject="UTM Status: " + fsession.flightplanstatus.value,
#                 body={'status':fsession.flightplanstatus.value, 'flightname':__build_flight_title(pilot, terminal), 'adminmail':config.logbook.admin_email, 'airportname':terminal.airportname, 'terminalname':terminal.terminalname, 'starttime':fsession.utmlaststart, 'endtime':fsession.utmlastend}
#             )
#     except:
#         # don't throw exception when notification fails
#         log.error(traceback.format_exc())

#     # notify admin in case of an error
#     try:
#         if fsession.flightplanstatus == FlightPlanStatus.error:
#             send_admin_notification(
#                 background_tasks=background_tasks,
#                 subject="UTM Interaktion fehlgeschlagen!",
#                 body={'message':'Bei einer Interaktion mit dem UTM System bzgl. dem Flug <b>"' + __build_flight_title(pilot,terminal) + '"</b> ist folgender Fehler aufgetreten:<br/><br/>' + error }
#             )
#     except:
#         # don't throw exception when notification fails
#         log.error(traceback.format_exc())

