import os.path
import configparser

from utils.logger import log

_ini = configparser.ConfigParser()

# config setup

def _loadConfigIni(path, required=False):
    log.info('loading config file: ' + path)
    if(os.path.isfile(path)):
        _ini.read(path)
    elif(required == True): 
        raise Exception('required config ' + path + ' not found!')

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

class TerminalConfig:
    def __init__(self, terminalid, airportname, terminaltype, apikey, terminalname, max_altitude_m, max_altitude_without_observer_m, max_num_flights, operatinghourscsv, dashboard_info_messages, dashboard_show_pilotid, pilot_info_messages, pilot_warn_messages, pilot_error_messages):
        self.terminalid = terminalid
        self.terminaltype = terminaltype
        self.terminalname = terminalname
        self.apikey = apikey
        self.airportname = airportname
        self.max_altitude_m = max_altitude_m
        self.max_altitude_without_observer_m = max_altitude_without_observer_m
        self.max_num_flights = max_num_flights
        self.operatinghourscsv = operatinghourscsv
        self.dashboard_info_messages = dashboard_info_messages
        self.dashboard_show_pilotid = dashboard_show_pilotid
        self.pilot_info_messages = pilot_info_messages
        self.pilot_warn_messages = pilot_warn_messages
        self.pilot_error_messages = pilot_error_messages

class Config:
    def __init__(self):
        self.logbook = LogbookConfig()
        self.terminals : dict[str,TerminalConfig] = _buildTerminalDict()
        self.smtp = SmtpConfig()

def _buildTerminalDict():
    retdict:dict = dict()
    for sectionname in _ini.sections():
        if sectionname.startswith('terminalconfig_'):            
            retdict[sectionname[15:]] = TerminalConfig(
                terminalid = sectionname[15:],
                terminaltype = _ini.get(sectionname, 'terminaltype'),
                terminalname = _ini.get(sectionname, 'terminalname'),
                apikey = _ini.get(sectionname, 'apikey'),
                airportname = _ini.get(sectionname, 'airportname'),
                max_altitude_m = _ini.get(sectionname, 'max_altitude_m', fallback=9999),
                max_altitude_without_observer_m = _ini.get(sectionname, 'max_altitude_without_observer_m', fallback=9999),
                max_num_flights = _ini.get(sectionname, 'max_num_flights', fallback=9999),
                operatinghourscsv = _ini.get(sectionname, 'operatinghourscsv', fallback=None),
                dashboard_info_messages = _ini.get(sectionname, 'dashboard_info_messages', fallback=None),
                dashboard_show_pilotid = _ini.getboolean(sectionname, 'dashboard_show_pilotid', fallback=False),
                pilot_info_messages = _ini.get(sectionname, 'pilot_info_messages', fallback=None),
                pilot_warn_messages = _ini.get(sectionname, 'pilot_warn_messages', fallback=None),
                pilot_error_messages = _ini.get(sectionname, 'pilot_error_messages', fallback=None),
            )
    return retdict

config = Config()

def __check_configurations():

    log.info('********************************************')
    log.info('        Model Flight Logbook Server')
    log.info('             version: ' + config.logbook.version)    
    log.info('********************************************')

    if config.logbook.apikey_admin == 'admin':
        log.warning('⚠  logbook.apikey_admin has default value --> specify unique key for security reason!')

    if not config.logbook.admin_email:
        log.warning('⚠  logbook.admin_email is not defined --> define an email adress in order to get notifications')

    if not config.smtp.server:
        log.warning('⚠  smtp.server is not defined --> define smtp configurations in order to enable email notifications')
    elif not config.smtp.from_email:
        log.error('⚠  smtp.from_email is not defined, but smtp.server is --> sending emails may not work')

    for terminalid in config.terminals:
        if config.terminals[terminalid].operatinghourscsv and not os.path.isfile(config.terminals[terminalid].operatinghourscsv):
            log.error('⚠  path '+config.terminals[terminalid].operatinghourscsv+' is defined for ' + terminalid +'.operatinghourscsv, but the file does not exist')
__check_configurations()