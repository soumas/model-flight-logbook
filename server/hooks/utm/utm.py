from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.firefox.options import Options
import time

#export MOZ_HEADLESS=1
#run script
#unset MOZ_HEADLESS 

driver = webdriver.Firefox() # executable_path=r'C:\Utility\BrowserDrivers\geckodriver.exe' */)
wait = WebDriverWait(driver, 10)

# login
print ("LOGIN")
driver.get("https://utm.dronespace.at/pm/")
wait.until(EC.url_matches('https://utm.dronespace.at/keycloak2/*'))
driver.find_element(By.NAME, "username").send_keys("XXXXXXX")
driver.find_element(By.NAME, "password").send_keys("XXXXXXX")
driver.find_element(By.NAME, "password").send_keys(Keys.RETURN)
wait.until(EC.url_matches('https://utm.dronespace.at/pm/my-account'))

# absprung auf avm (karte)
print ("OPEN MAP")
time.sleep(1)
driver.find_element(By.CLASS_NAME, "logo").click()
time.sleep(3)

# agbs akzeptieren
print ("ACCEPT TERMS")
wait.until(EC.url_matches('https://utm.dronespace.at/avm/#p=*'))
driver.find_element(By.XPATH, "//*[@class='button ok']").click() # agb akzeptieren

print ("FORM")
driver.find_element(By.ID, "fly-button").click() # formular overlay
driver.find_element(By.CSS_SELECTOR, "input[type='file']").send_keys('/home/thomas/MSGU/MSGU/Verschiedenes/Daten für GoogleEarth/GoogleEarth 150m MFBO/MSGU für MFBO.kml')
driver.find_element(By.XPATH, "//*[@class='ti ti-arrow-right']").click()
driver.find_element(By.XPATH, "//label[normalize-space()='Maximum takeoff mass (g) *']/following-sibling::input").send_keys("24000")
driver.find_element(By.XPATH, "//label[normalize-space()='Max. altitude above ground (m) *']/following-sibling::input").send_keys("119")
driver.find_element(By.XPATH, "//label[normalize-space()='Public title of your flight *']/following-sibling::input").send_keys("Modellflugplatz MSGU")

driver.find_element(By.XPATH, "//label[normalize-space()='End date and time *']/following-sibling::div/input").send_keys(Keys.CONTROL + "a")
driver.find_element(By.XPATH, "//label[normalize-space()='End date and time *']/following-sibling::div/input").send_keys(Keys.DELETE)
driver.find_element(By.XPATH, "//label[normalize-space()='End date and time *']/following-sibling::div/input").send_keys("05.08.2024 23:45")

driver.find_element(By.XPATH, "//label[normalize-space()='Start date and time *']/following-sibling::div/input").send_keys(Keys.CONTROL + "a")
driver.find_element(By.XPATH, "//label[normalize-space()='Start date and time *']/following-sibling::div/input").send_keys(Keys.DELETE)
driver.find_element(By.XPATH, "//label[normalize-space()='Start date and time *']/following-sibling::div/input").send_keys("05.08.2024 23:00")

driver.find_element(By.XPATH, "//label[normalize-space()='Public title of your flight *']/following-sibling::input").click() # click any other element to hide calendar
driver.find_element(By.XPATH, "//*[@class='ti ti-arrow-right']").click()

# fake bug
print ("ALL DONE")

driver.close()