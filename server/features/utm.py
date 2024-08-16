from fastapi import BackgroundTasks
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
from config.manager import config
from db.manager import SessionLocal
from features.send_mail import send_mail

 
DEFAULT_WAIT_TIME = 5
DATETIME_FORMAT = '%d.%m.%Y %H:%M'
DATETIME_FORMAT_WITH_SECONDS = '%d.%m.%Y %H:%M:%S'

def __create_driver():
    options = FirefoxOptions()
    #options.add_argument("--headless")
    return webdriver.Firefox(options=options)

def __dispose_driver(driver):    
    driver.close()

def __wait_until_url_loaded(driver, url, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.url_matches(url))

def __wait_until_clickable(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))

def __wait_and_click(driver, xpath, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).click()

def __wait_and_send_key(driver, xpath, text, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).send_keys(Keys.CONTROL + "a")
    driver.find_element(By.XPATH, xpath).send_keys(Keys.DELETE)
    driver.find_element(By.XPATH, xpath).send_keys(text)

def __build_flight_title_id_part(pilot_id):
    return 'ID: {}'.format(pilot_id)

def __build_flight_title(pilot: PilotEntity):
    return '{} (Modellflugplatz {}, {} {})'.format(config.common.clubname, __build_flight_title_id_part(pilot.id), pilot.firstname, pilot.lastname)

def __utm_login(driver):
    print ("NAVIGATE TO START PAGE")
    driver.get("https://utm.dronespace.at/avm/?#p=5/47.74/13.23")

    print ("ACCEPT TERMS")
    __wait_and_click(driver, "//*[@class='button ok']") # agb akzeptieren
    
    print("LOGIN")
    __wait_and_click(driver, "//a[normalize-space()='Sign in / Sign up']")
    __wait_until_url_loaded(driver, 'https://utm.dronespace.at/keycloak2/*')
    __wait_and_send_key(driver, "//input[@id='username']", config.utm.username)
    __wait_and_send_key(driver, "//input[@id='password']", config.utm.password)
    __wait_and_click(driver, "//button[@type='submit']")

def __utm_open_menu(driver):
    # workaround for the buggy menu button
    for i in range(5):
        try:
            __wait_and_click(driver, "//div[@id='menu-button']")
            time.sleep(1)
            __wait_until_clickable(driver, "//span[normalize-space()='Flight plans and log']")
        except:
            pass


def __set_flightplan_status(id:int, status:FlightPlanStatus):
    db = SessionLocal()
    try :
        fsession:FlightSessionEntity = db.query(FlightSessionEntity).filter(FlightSessionEntity.id == id).first()
        fsession.flightplan_status = status
        db.commit()
    except:
        db.rollback()
        raise
    finally:
        db.close()

def start_flight(background_tasks: BackgroundTasks, pilot: PilotEntity, fligthsession: FlightSessionEntity):
    try:
        if config.utm.enabled != True:
            return

        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.pending)

        driver = __create_driver();

        __utm_login(driver)

        print ("CREATE FLIGHT PLAN")
        __wait_until_clickable(driver, "//i[@class='ti ti-link']") # wait until ui recognizes login state
        __wait_and_click(driver, "//i[@class='ti ti-drone']") # open form
        driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys(config.utm.kml_path)
        __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
        __wait_and_send_key(driver, "//label[normalize-space()='First name *']/following-sibling::input", pilot.firstname)
        __wait_and_send_key(driver, "//label[normalize-space()='Last name *']/following-sibling::input", pilot.lastname)
        __wait_and_send_key(driver, "//label[normalize-space()='Phone number *']/following-sibling::input",pilot.phonenumber)
        __wait_and_send_key(driver, "//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input", config.utm.mtom_g)
        __wait_and_send_key(driver, "//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input",config.utm.max_altitude_m)
        __wait_and_send_key(driver, "//label[normalize-space()='Public title of your flight *']/following-sibling::input", __build_flight_title(pilot))
        startDateTime = datetime.now().replace(second=0, microsecond=0) + timedelta(minutes=1)
        endDateTime = startDateTime + timedelta(hours=4)
        __wait_and_send_key(driver, "//label[normalize-space()='Start date and time *']/following-sibling::div/input", startDateTime.strftime(DATETIME_FORMAT))
        __wait_and_send_key(driver, "//label[normalize-space()='End date and time *']/following-sibling::div/input", endDateTime.strftime(DATETIME_FORMAT))
        __wait_and_click(driver, "//input[@class='input']") # close calendar controls by clicking any other input field
        __wait_and_click(driver, "//i[@class='ti ti-arrow-right']")
        __wait_and_click(driver, "//i[@class='ti ti-send']")

        print ("ACTIVATE FLIGHT PLAN")
        secondsBeforeStartTime = (startDateTime - datetime.now()).total_seconds() + 90; # 90 seconds buffer to be sure that start time is in the past
        if(secondsBeforeStartTime>0):
            print ("WAITING " + str(secondsBeforeStartTime) + " SECONDS FOR START TIME")
            time.sleep(secondsBeforeStartTime) 
        driver.refresh()
        __utm_open_menu(driver)
        __wait_and_click(driver, "//span[normalize-space()='Flight plans and log']")
        __wait_and_click(driver, "//div[@class='waiting-plans']/div[@class='operation-plan']/div[@class='status APPROVED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot.id) + "')]", 60)
        __wait_and_click(driver, "//button[normalize-space()='Activate flight plan']")

        print ("WAIT FOR SUCCESS MESSAGE")
        __wait_until_clickable(driver, "//button[normalize-space()='End flight']", 60)

        print ("FINISHED")

        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.flying)

        if config.utm.notify_pilot:
            try:
                background_tasks.add_task(
                    send_mail, 
                    background_tasks, 
                    "utm_status.html",
                    "UTM Statusänderung",
                    pilot.email,
                    {'status':FlightPlanStatus.flying.value, 'flightname':__build_flight_title(pilot)})
            except:
                # don't throw exception when notification fails
                traceback.print_exc()
    except:
        traceback.print_exc()
        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.error)
    finally:
        __dispose_driver(driver)


def end_flight(background_tasks: BackgroundTasks, pilot: PilotEntity, fligthsession: FlightSessionEntity):
    try:

        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.pending)

        driver = __create_driver()
        __utm_login(driver)
        print("END FLIGHT")
        __utm_open_menu(driver)
        __wait_and_click(driver, "//span[normalize-space()='Flight plans and log']")        
        __wait_and_click(driver, "//div[@class='operation-plans']/div[@class='operation-plan']/div[@class='status ACTIVATED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot.id) + "')]")
        __wait_and_click(driver, "//button[normalize-space()='End flight']")
        print ("FINISHED")

        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.closed)

        if config.utm.notify_pilot:
            try:
                background_tasks.add_task(
                    send_mail, 
                    background_tasks, 
                    "utm_status.html",
                    "UTM Statusänderung",
                    pilot.email,
                    {'status':FlightPlanStatus.closed.value, 'flightname':__build_flight_title(pilot)})
            except:
                # don't throw exception when notification fails
                traceback.print_exc()
    except:
        traceback.print_exc()
        __set_flightplan_status(id=fligthsession.id, status=FlightPlanStatus.error)  
    finally:
        __dispose_driver(driver)
