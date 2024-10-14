from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.security import APIKeyHeader

from utils.logger import *
from config.configmanager import config
from db.dbmanager import execute_db_migration

from utils.logger import log

@asynccontextmanager
async def lifespan(app: FastAPI):
    # before first reqeust (startup event)
    log.debug('startup event occured')
    execute_db_migration()
    yield
    # after last request (shutdown event)
    log.debug('shutdown event occured')

api = FastAPI(debug=True, lifespan=lifespan)
api_key_header = APIKeyHeader(name="x-api-key")
