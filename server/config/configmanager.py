import argparse
import os.path
import configparser
import sys

from utils.logger import log

_ini = configparser.ConfigParser()

# config setup

def _loadConfigIni(path, required=False):
    log.info('loading config file: ' + path)
    if(os.path.isfile(path)):
        _ini.read(path)
    elif(required == True): 
        raise Exception('required config ' + path + ' not found!')
    else:
        log.debug('config file not found!')

def __init():
    _loadConfigIni(path='./server-config-default.ini', required=True)
    _loadConfigIni(path='./server-config.ini')
    _loadConfigIni(path='./server-config-dev.ini')
__init()

def _read_version():
    with open('version') as f:
        return f.readline()

class LogbookConfig:
    def __init__(self):
        self.version = _read_version()
        self.dburl = _ini.get('logbook','dburl')
        self.apikey_admin = _ini.get('logbook','apikey_admin')
        self.admin_email = _ini.get('logbook','admin_email')
        self.forward_comment = _ini.getboolean('logbook','forward_comment')
        self.chromedriver_path = _ini.get('logbook', 'chromedriver_path')
        self.debug = _ini.getboolean('logbook','debug')

class SmtpConfig:
    def __init__(self):
        self.username = _ini.get('smtp','username')
        self.password = _ini.get('smtp','password')
        self.server = _ini.get('smtp','server')
        self.port = _ini.getint('smtp','port')
        self.from_email = _ini.get('smtp','from_email')
        self.from_name = _ini.get('smtp','from_name')
        self.starttls = _ini.getboolean('smtp','starttls')
        self.ssl_tls = _ini.getboolean('smtp','ssl_tls')
        self.use_credentials = _ini.getboolean('smtp','use_credentials')
        self.validate_certs = _ini.getboolean('smtp','validate_certs')
        self.timeout = _ini.getint('smtp','timeout')
        self.template_folder = _ini.get('smtp','template_folder')
        self.suppress_send = _ini.getboolean('smtp', 'suppress_send')

class UtmConfig:
    def __init__(self):
        self.enabled = _ini.getboolean('utm','enabled')
        self.username = _ini.get('utm','username')
        self.password = _ini.get('utm','password')
        self.max_altitude_m = _ini.get('utm','max_altitude_m')
        self.mtom_g = _ini.get('utm','mtom_g')
        self.notify_pilot = _ini.getboolean('utm','notify_pilot')
        self.simulate = _ini.getboolean('utm','simulate')

class TerminalConfig:
    def __init__(self, airportname, terminaltype, apikey, airportkml, terminalname, pilotidinstruction):
        self.terminaltype = terminaltype
        self.terminalname = terminalname
        self.apikey = apikey
        self.airportname = airportname
        self.airportkml = airportkml
        self.pilotidinstruction = pilotidinstruction

class Config:
    def __init__(self):
        self.logbook = LogbookConfig()
        self.terminals = _buildTerminalDict()
        self.smtp = SmtpConfig()
        self.utm = UtmConfig()

def _buildTerminalDict():
    retdict:dict = dict()
    for sectionname in _ini.sections():
        if sectionname.startswith('terminalconfig_'):            
            retdict[sectionname[15:]] = TerminalConfig(
                terminaltype = _ini.get(sectionname, 'terminaltype'),
                terminalname = _ini.get(sectionname, 'terminalname'),
                apikey = _ini.get(sectionname, 'apikey'),
                airportname = _ini.get(sectionname, 'airportname'),
                airportkml = _ini.get(sectionname, 'airportkml'),
                pilotidinstruction = _ini.get(sectionname, 'pilotidinstruction'),
            )
    return retdict

config = Config()

def __check_configurations():

    log.info('********************************************')
    log.info('        Model Flight Logbook Server')
    log.info('             version: ' + config.logbook.version)    
    log.info('********************************************')

    if config.logbook.apikey_admin == 'admin':
        log.warning('logbook.apikey_admin has default value --> specify unique key for security reason!')

    if not config.logbook.admin_email:
        log.warning('logbook.admin_email is not defined --> define an email adress in order to get notifications')

    if not config.smtp.server:
        log.warning('smtp.server is not defined --> define smtp configurations in order to enable email notifications')
    elif not config.smtp.from_email:
        log.error('!!!!! smtp.from_email is not defined, but smtp.server is --> sending emails may not work !!!!!')

    if not config.utm.enabled:
        log.info('utm feature is disabled --> define utm configurations in order to enable the feature')
    elif not config.utm.max_altitude_m or not config.utm.mtom_g or not config.utm.password or not config.utm.username:
        log.error('!!!!! utm feature is enabled but not all required utm configurations are availabe --> check out the docs !!!!!')

__check_configurations()