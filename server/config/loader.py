import os.path
import configparser

config = configparser.ConfigParser()
config.read('config-defaults.ini')
if(os.path.isfile('config.ini')):
    config.read('config.ini')