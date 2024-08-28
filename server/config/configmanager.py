import os.path
import configparser

from utils.logger import log

# config setup
_ini = configparser.ConfigParser()
_ini.read('config-default.ini')
if(os.path.isfile('config.ini')):
    _ini.read('config.ini')

def _read_version():
    with open('version') as f:
        return f.readline()

class CommonConfig:
    def __init__(self):
        self.version = _read_version()
        self.clubname = _ini.get('common','clubname')
        self.admin_email = _ini.get('common','admin_email')
        self.debug = _ini.getboolean('common','debug')

class ApiConfig:
    def __init__(self):
        self.apikey_admin = _ini.get('api','apikey_admin')
        self.apikey_terminal = _ini.get('api','apikey_terminal')

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
        self.debug = _ini.getboolean('smtp', 'debug')

class DbConfig:
    def __init__(self):
        self.url = _ini.get('db','url')

class UtmConfig:
    def __init__(self):
        self.enabled = _ini.getboolean('utm','enabled')
        self.username = _ini.get('utm','username')
        self.password = _ini.get('utm','password')
        self.kml_path = _ini.get('utm','kml_path')
        self.max_altitude_m = _ini.get('utm','max_altitude_m')
        self.mtom_g = _ini.get('utm','mtom_g')
        self.notify_pilot = _ini.getboolean('utm','notify_pilot')
        self.simulate = _ini.getboolean('utm','simulate')

class Config:
    def __init__(self):
        self.common = CommonConfig()
        self.api = ApiConfig()
        self.smtp = SmtpConfig()
        self.db = DbConfig()
        self.utm = UtmConfig()

config = Config()
