from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
import time
#import pyautogui

driver = webdriver.Firefox()
wait = WebDriverWait(driver, 10)

# login
driver.get("https://utm.dronespace.at/pm/")
wait.until(EC.url_matches('https://utm.dronespace.at/keycloak2/*'))
elem = driver.find_element(By.NAME, "username")
elem.send_keys("XXXXX")
elem = driver.find_element(By.NAME, "password")
elem.send_keys("XXXXX")
elem.send_keys(Keys.RETURN)
wait.until(EC.url_matches('https://utm.dronespace.at/pm/my-account'))

# absprung auf avm (karte)
time.sleep(10)
# todo: lädt nicht wenn selenium klickt ... wenn man selber klickt schon
#element = driver.find_element(By.CLASS_NAME, "logo").click()


wait.until(EC.url_matches('https://utm.dronespace.at/avm/#p=*'))
driver.find_element(By.XPATH, "//*[@class='button ok']").click() # agb akzeptieren
driver.find_element(By.ID, "fly-button").click() # formular overlay
driver.find_element(By.XPATH, "//*[@class='button fileinput']").click() # open file selector
#pyautogui.write('/home/thomas/MSGU/MSGU/Verschiedenes/Daten für GoogleEarth/GoogleEarth 150m MFBO/MSGU für MFBO.kml') 
#pyautogui.press('enter')



#wait.until(EC.url_matches('https://utm.dronespace.at/avm'))
assert "Python" in driver.title
driver.close()