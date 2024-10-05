from fastapi import BackgroundTasks
import selenium
from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
from datetime import datetime, timedelta
import time
import traceback

from db.entities import FlightPlanStatus, FlightSessionEntity, PilotEntity
from config.configmanager import TerminalConfig, config
from db.dbmanager import SessionLocal
from utils.send_mail import send_admin_notification, send_mail
from utils.logger import log

 
DEFAULT_WAIT_TIME = 5
DATETIME_FORMAT = '%d.%m.%Y %H:%M'
DATETIME_FORMAT_WITH_SECONDS = '%d.%m.%Y %H:%M:%S'

def __create_driver():
    log.debug('__create_driver')
    options = FirefoxOptions()
    options.add_argument("--headless")
    return webdriver.Firefox(options=options)

def __dispose_driver(driver):
    log.debug('__dispose_driver')
    driver.close()

def __wait_until_url_loaded(driver, url, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_until_url_loaded, url {}, timeout {}'.format(url, timeout))
    WebDriverWait(driver, timeout).until(EC.url_matches(url))

def __wait_until_clickable(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_until_clickable, xpath {}, timeout {}'.format(xpath, timeout))
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))

def __wait_and_click(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_and_click, xpath {}, timeout {}'.format(xpath, timeout))
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).click()

def __wait_and_send_key(driver, xpath, text, timeout=DEFAULT_WAIT_TIME):
    log.debug('__wait_and_send_key, xpath {}, text ***, timeout {}'.format(xpath, timeout))
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).send_keys(Keys.CONTROL + "a")
    driver.find_element(By.XPATH, xpath).send_keys(Keys.DELETE)
    driver.find_element(By.XPATH, xpath).send_keys(text)

def __build_flight_title_id_part(pilotid):
    return ' ({})'.format(pilotid)

def __build_flight_title(pilot: PilotEntity, terminal: TerminalConfig):
    return '{}, {} {} {}'.format(terminal.airportname, pilot.firstname, pilot.lastname, __build_flight_title_id_part(pilot.id))

def __utm_login(driver):    
    log.debug('__utm_login')

    driver.get('https://utm.dronespace.at/avm/?#p=5/47.74/13.23')

    log.debug('accept terms and conditions')
    __wait_and_click(driver, "//*[@class='button ok']") # agb akzeptieren
    
    log.debug('handle login form')
    __wait_and_click(driver, "//a[normalize-space()='Sign in / Sign up']")
    __wait_until_url_loaded(driver, 'https://utm.dronespace.at/keycloak2/*')
    __wait_and_send_key(driver, "//input[@id='username']", config.utm.username)
    __wait_and_send_key(driver, "//input[@id='password']", config.utm.password)
    __wait_and_click(driver, "//button[@type='submit']")

def __utm_open_menu(driver):
    log.debug('__utm_open_menu')
    # workaround for the buggy menu button
    for i in range(5):
        try:
            __wait_and_click(driver, "//div[@id='menu-button']")
            time.sleep(1)
            __wait_until_clickable(driver, "//span[normalize-space()='Flight plans and log']")
        except:
            log.debug('buggy menu fallback')
            pass


def __set_flightplanstatus(id:int, status:FlightPlanStatus):
    log.debug('__set_flightplanstatus ({})'.format(status.value))
    db = SessionLocal()
    try :
        fsession:FlightSessionEntity = db.query(FlightSessionEntity).filter(FlightSessionEntity.id == id).first()
        fsession.flightplanstatus = status
        db.commit()
        db.refresh(fsession)
        return fsession
    except:
        db.rollback()
        raise
    finally:
        db.close()

def __send_notification(background_tasks: BackgroundTasks, pilot: PilotEntity, fsession:FlightSessionEntity, terminal:TerminalConfig, error: str):    
    log.debug('__send_notification ({})'.format(pilot.id))

    # notify pilot
    try:
        if config.utm.notify_pilot:
            send_mail(
                background_tasks=background_tasks,
                template_name="pilot_utm_status.html",
                email_to=pilot.email,
                subject="UTM Status: " + fsession.flightplanstatus.value,
                body={'status':fsession.flightplanstatus.value, 'flightname':__build_flight_title(pilot, terminal), 'adminmail':config.logbook.admin_email}
            )
    except:
        # don't throw exception when notification fails
        log.error(traceback.format_exc())

    # notify admin in case of an error
    try:
        if fsession.flightplanstatus == FlightPlanStatus.error:
            send_admin_notification(
                background_tasks=background_tasks,
                subject="UTM Interaktion fehlgeschlagen!",
                body={'message':'Bei einer Interaktion mit dem UTM System bzgl. dem Flug <b>"' + __build_flight_title(pilot,terminal) + '"</b> ist folgender Fehler aufgetreten:<br/><br/>' + error }
            )
    except:
        # don't throw exception when notification fails
        log.error(traceback.format_exc())
        


def start_flight(background_tasks: BackgroundTasks, pilot: PilotEntity, fligthsession: FlightSessionEntity, terminal: TerminalConfig):
    
    log.debug('utm start flight for pilot: {}'.format(pilot.id))

    if not config.utm.enabled:
        log.debug('utm feature is not configured')
        __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.featureDisabled)
        return
    
    driver = None
    error = None

    try:
        __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.startPending)

        if config.utm.simulate != True:

            driver = __create_driver()

            __utm_login(driver)

            log.debug('create flight plan')
            __wait_until_clickable(driver, "//i[@class='ti ti-link']") # wait until ui recognizes login state
            __wait_and_click(driver, "//i[@class='ti ti-drone']") # open form
            driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys(terminal.airportkml)
            __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
            __wait_and_send_key(driver, "//label[normalize-space()='First name *']/following-sibling::input", pilot.firstname)
            __wait_and_send_key(driver, "//label[normalize-space()='Last name *']/following-sibling::input", pilot.lastname)
            __wait_and_send_key(driver, "//label[normalize-space()='Phone number *']/following-sibling::input",pilot.phonenumber)
            __wait_and_send_key(driver, "//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input", config.utm.mtom_g)
            __wait_and_send_key(driver, "//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input",config.utm.max_altitude_m)
            __wait_and_send_key(driver, "//label[normalize-space()='Public title of your flight *']/following-sibling::input", __build_flight_title(pilot, terminal))
            startDateTime = datetime.now().replace(second=0, microsecond=0) + timedelta(minutes=1)
            endDateTime = startDateTime + timedelta(hours=4)
            __wait_and_send_key(driver, "//label[normalize-space()='Start date and time *']/following-sibling::div/input", startDateTime.strftime(DATETIME_FORMAT))
            __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", endDateTime.strftime(DATETIME_FORMAT))
            __wait_and_click(driver, "//input[@class='input']") # close calendar controls by clicking any other input field
            __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
            __wait_and_click(driver, "//i[@class='ti ti-send']")

            secondsBeforeStartTime = (startDateTime - datetime.now()).total_seconds() + 90 # 90 seconds buffer to be sure that start time is in the past
            if(secondsBeforeStartTime>0):
                log.debug('waiting ' + str(secondsBeforeStartTime) + 'seconds for start time')
                time.sleep(secondsBeforeStartTime) 
            log.debug('reload page {}'.format(driver.current_url))
            driver.refresh()
            log.debug('activate flight plan')
            __utm_open_menu(driver)
            __wait_and_click(driver, "//span[normalize-space()='Flight plans and log']")
            __wait_and_click(driver, "//div[@class='waiting-plans']/div[@class='operation-plan']/div[@class='status APPROVED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot.id) + "')]", 60)
            __wait_and_click(driver, "//button[normalize-space()='Activate flight plan']")

            log.debug('wait for success message')
            __wait_until_clickable(driver, "//button[normalize-space()='End flight']", 60)

            log.debug('flight plan activated')

        else:
            log.warning('utm simulation mode is active - waiting some seconds and doing nothing')
            time.sleep(10)

        fligthsession = __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.flying)

    except:
        error = traceback.format_exc()
        log.error(error)
        fligthsession = __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.error)
    finally:        
        if driver != None:
            __dispose_driver(driver)
        __send_notification(background_tasks=background_tasks, pilot=pilot, fsession=fligthsession, terminal=terminal, error=error)


def end_flight(background_tasks: BackgroundTasks, pilot: PilotEntity, fligthsession: FlightSessionEntity, terminal: TerminalConfig):
    
    log.debug('utm end flight for pilot {}'.format(pilot.id))
    if not config.utm.enabled:
        log.debug('utm feature is not configured')
        __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.featureDisabled)
        return

    driver = None
    error = None

    try:

        __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.endPending)

        if config.utm.simulate != True:

            driver = __create_driver()

            __utm_login(driver)
            log.debug('navigate to flightplan with id part {}'.format(__build_flight_title_id_part(pilot.id)))
            __utm_open_menu(driver)
            __wait_and_click(driver, "//span[normalize-space()='Flight plans and log']")
            try:
                __wait_and_click(driver, "//div[@class='operation-plans']/div[@class='operation-plan']/div[@class='status ACTIVATED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot.id) + "')]")
                __wait_and_click(driver, "//button[normalize-space()='End flight']")
            except selenium.common.exceptions.TimeoutException:
                log.warning('Flight with id part "{}" not found in active flights list. Maybe the flight ended earlier...?'.format(__build_flight_title_id_part(pilot.id)))
                pass

            log.debug('flight plan ended')
            
        else:
            log.warning('utm simulation mode is active - waiting some minutes and doing nothing')
            time.sleep(10)

        fligthsession = __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.closed)

    except:
        error = traceback.format_exc()
        log.error(error)
        fligthsession = __set_flightplanstatus(id=fligthsession.id, status=FlightPlanStatus.error)
    finally:
        if driver != None:
            __dispose_driver(driver) 
        __send_notification(background_tasks=background_tasks, pilot=pilot, fsession=fligthsession, terminal=terminal, error=error)
