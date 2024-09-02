import os.path
import configparser

from utils.logger import log

_ini = configparser.ConfigParser()

# config setup
def __init():    
    log.debug('loading config-default.ini')
    _ini.read('config-default.ini')
    if(os.path.isfile('config.ini')):
        log.debug('loading config.ini')
        _ini.read('config.ini')
__init()

def _read_version():
    with open('version') as f:
        return f.readline()

class LogbookConfig:
    def __init__(self):
        self.version = _read_version()
        self.dburl = _ini.get('logbook','dburl')
        self.apikey_admin = _ini.get('logbook','apikey_admin')
        self.apikey_terminal = _ini.get('logbook','apikey_terminal')
        self.admin_email = _ini.get('logbook','admin_email')
        self.forward_comment = _ini.getboolean('logbook','forward_comment')
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
        self.starturl = _ini.get('utm','starturl')
        self.username = _ini.get('utm','username')
        self.password = _ini.get('utm','password')
        self.kml_path = _ini.get('utm','kml_path')
        self.airport = _ini.get('utm','airport')
        self.max_altitude_m = _ini.get('utm','max_altitude_m')
        self.mtom_g = _ini.get('utm','mtom_g')
        self.notify_pilot = _ini.getboolean('utm','notify_pilot')
        self.simulate = _ini.getboolean('utm','simulate')

class Config:
    def __init__(self):
        self.logbook = LogbookConfig()
        self.smtp = SmtpConfig()
        self.utm = UtmConfig()

config = Config()

def __check_configurations():
    log.info('********************************************')
    log.info('        Dronespace Logbook Server')
    log.info('             version: ' + config.logbook.version)    
    log.info('********************************************')

    if config.logbook.apikey_admin == 'admin':
        log.warn('logbook.apikey_admin has default value --> specify unique key for security reason!')

    if config.logbook.apikey_terminal == 'terminal':
        log.warn('logbook.apikey_terminal has default value --> specify unique key for security reason!')

    if not config.logbook.admin_email:
        log.warn('logbook.admin_email is not defined --> define an email adress in order to get notifications')

    if not config.smtp.server:
        log.warn('smtp.server is not defined --> define smtp configurations in order to enable email notifications')
    elif not config.smtp.from_email:
        log.error('!!!!! smtp.from_email is not defined, but smtp.server is --> sending emails may not work !!!!!')

    if not config.utm.username:
        log.warn('utm.username is not defined --> define utm configurations in order to enable the utm feature')
    elif not config.utm.airport or not config.utm.kml_path or not config.utm.max_altitude_m or not config.utm.mtom_g or not config.utm.password or not config.utm.starturl:
        log.error('!!!!! utm.username is defined but not all required utm configurations are availabe --> check out the docs !!!!!')

__check_configurations()