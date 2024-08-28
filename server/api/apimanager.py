from fastapi import FastAPI
from fastapi.security import APIKeyHeader

from utils.logger import *
from config.configmanager import config

def on_startup():
    log.info('********************************************')
    log.info('Dronespace Logbook Server is up and running')
    log.info('Version: ' + config.common.version)
    log.info('https://github.com/soumas/dronespace-logbook')
    log.info('********************************************')

api = FastAPI(debug=True, on_startup=[on_startup])
api_key_header = APIKeyHeader(name="x-api-key", auto_error=False)