
from contextlib import asynccontextmanager
import ssl
from fastapi import FastAPI
from fastapi.security import APIKeyHeader
from utils.scheduler import scheduler
from config.configmanager import config
from db.dbmanager import execute_db_migration

from tasks.utm_tasks import *
from tasks.flightsession_tasks import *

@asynccontextmanager
async def lifespan(app: FastAPI):
    # before first reqeust (startup event)
    execute_db_migration()
    scheduler.start()
    # run server
    yield
    # after last request (shutdown event)
    scheduler.shutdown()


api = FastAPI(debug=config.logbook.debug, lifespan=lifespan)
api_key_header = APIKeyHeader(name="x-api-key")

ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ssl_context.load_cert_chain('/home/pi/model-flight-logbook/cert.pem', keyfile='/home/pi/model-flight-logbook/key.pem')