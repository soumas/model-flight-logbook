from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
from datetime import datetime, timedelta
from selenium.common.exceptions import NoAlertPresentException
import time

#export MOZ_HEADLESS=1
#run script
#unset MOZ_HEADLESS 

DEFAULT_WAIT_TIME = 5
DATETIME_FORMAT = '%d.%m.%Y %H:%M'
DATETIME_FORMAT_WITH_SECONDS = '%d.%m.%Y %H:%M:%S'

driver = None

def __init_driver():
    global driver
    driver = webdriver.Firefox() # executable_path=r'C:\Utility\BrowserDrivers\geckodriver.exe' */)

def __dispose_driver():
    global driver
    driver.close()

def __wait_until_url_loaded(url, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.url_matches(url))

def __wait_until_clickable(xpath, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))

def __wait_and_click(xpath, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).click()

def __wait_and_send_key(xpath, text, timeout=DEFAULT_WAIT_TIME):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((By.XPATH, xpath)))
    driver.find_element(By.XPATH, xpath).send_keys(Keys.CONTROL + "a")
    driver.find_element(By.XPATH, xpath).send_keys(Keys.DELETE)
    driver.find_element(By.XPATH, xpath).send_keys(text)

def __build_flight_title_id_part(pilot_id):
    return 'ID: {}'.format(pilot_id)

def __build_flight_title(airport, pilot_id, pilot_firstname, pilot_lastname):
    return '{} ({}, {} {})'.format(airport, __build_flight_title_id_part(pilot_id), pilot_firstname, pilot_lastname)

def __utm_login(username, password):
    print ("NAVIGATE TO START PAGE")
    driver.get("https://utm.dronespace.at/avm/?#p=5/47.74/13.23")

    print ("ACCEPT TERMS")
    __wait_and_click("//*[@class='button ok']") # agb akzeptieren
    
    print("LOGIN")
    __wait_and_click("//a[normalize-space()='Sign in / Sign up']")
    __wait_until_url_loaded('https://utm.dronespace.at/keycloak2/*')
    __wait_and_send_key("//input[@id='username']", username)
    __wait_and_send_key("//input[@id='password']", password)
    __wait_and_click("//button[@type='submit']")

def __utm_open_menu():
    # workaround for the buggy menu button
    for i in range(3):
        try:
            __wait_and_click("//div[@id='menu-button']")
            __wait_until_clickable("//span[normalize-space()='Flight plans and log']")
        except:
            if i < 3:
                pass
            else:
                raise
                        
def utm_start_flight(username, password, kml_path, airport, pilot_id, pilot_firstname, pilot_lastname, pilot_phonenumber, mtom_g, max_altitude_m):
    try:
        __init_driver();

        __utm_login(username, password)

        print ("CREATE FLIGHT PLAN")
        __wait_until_clickable("//i[@class='ti ti-link']") # wait until ui recognizes login state
        __wait_and_click("//i[@class='ti ti-drone']") # open form
        driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys(kml_path)
        __wait_and_click("//i[@class='ti ti-arrow-right']")
        __wait_and_send_key("//label[normalize-space()='First name *']/following-sibling::input", pilot_firstname)
        __wait_and_send_key("//label[normalize-space()='Last name *']/following-sibling::input", pilot_lastname)
        __wait_and_send_key("//label[normalize-space()='Phone number *']/following-sibling::input",pilot_phonenumber)
        __wait_and_send_key("//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input",mtom_g)
        __wait_and_send_key("//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input",max_altitude_m)
        __wait_and_send_key("//label[normalize-space()='Public title of your flight *']/following-sibling::input", __build_flight_title(airport, pilot_id, pilot_firstname, pilot_lastname))
        startDateTime = datetime.now().replace(second=0, microsecond=0) + timedelta(minutes=1)
        endDateTime = startDateTime + timedelta(hours=4)
        __wait_and_send_key("//label[normalize-space()='Start date and time *']/following-sibling::div/input", startDateTime.strftime(DATETIME_FORMAT))
        __wait_and_send_key("//label[normalize-space()='End date and time *']/following-sibling::div/input", endDateTime.strftime(DATETIME_FORMAT))
        __wait_and_click("//input[@class='input']") # close calendar controls by clicking any other input field
        __wait_and_click("//i[@class='ti ti-arrow-right']")
        __wait_and_click("//i[@class='ti ti-send']")

        print ("ACTIVATE FLIGHT PLAN")
        secondsBeforeStartTime = (startDateTime - datetime.now()).total_seconds() + 60;
        if(secondsBeforeStartTime>0):
            print ("WAITING " + str(secondsBeforeStartTime) + " SECONDS FOR START TIME")
            time.sleep(secondsBeforeStartTime) 
        driver.refresh()
        __utm_open_menu()
        __wait_and_click("//span[normalize-space()='Flight plans and log']")
        __wait_and_click("//div[@class='waiting-plans']/div[@class='operation-plan']/div[@class='status APPROVED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot_id) + "')]", 60)
        __wait_and_click("//button[normalize-space()='Activate flight plan']")

        print ("WAIT FOR SUCCESS MESSAGE")
        __wait_until_clickable("//button[normalize-space()='End flight']", 60)

        print ("FINISHED")
    finally:
        __dispose_driver()

def utm_end_flight(username, password, pilot_id):
    try:
        __init_driver()
        __utm_login(username, password)
        print("END FLIGHT")
        __utm_open_menu()
        __wait_and_click("//span[normalize-space()='Flight plans and log']")        
        __wait_and_click("//div[@class='operation-plans']/div[@class='operation-plan']/div[@class='status ACTIVATED']/following-sibling::p[contains(normalize-space(.), '" + __build_flight_title_id_part(pilot_id) + "')]")
        __wait_and_click("//button[normalize-space()='End flight']")
        print ("FINISHED")        
    finally:
        __dispose_driver()

if __name__ == "__main__":
	# utm_start_flight(
    #     username='',
    #     password='',
    #     kml_path='/home/thomas/MSGU/MSGU/Verschiedenes/Daten für GoogleEarth/GoogleEarth 150m MFBO/MSGU für MFBO.kml',
    #     airport='Modellflugplatz MSGU',
    #     pilot_id='0003844323',
    #     pilot_firstname='Thomas',
    #     pilot_lastname='Juen',
    #     pilot_phonenumber='+43664/88501741',
    #     max_altitude_m='119',
    #     mtom_g='24000'
    # )
    utm_end_flight(username='',password='',pilot_id='0003844323')

	# utm_start_flight(
    #     username='',
    #     password='',
    #     kml_path='/home/thomas/MSGU/MSGU/Verschiedenes/Daten für GoogleEarth/GoogleEarth 150m MFBO/MSGU für MFBO.kml',
    #     airport='Modellflugplatz MSGU',
    #     pilot_id='0003845555',
    #     pilot_firstname='Testuser',
    #     pilot_lastname='Eins',
    #     pilot_phonenumber='+43664/88501741',
    #     max_altitude_m='119',
    #     mtom_g='24000'
    # )
    #utm_end_flight(username='',password='',pilot_id='0003845555')
