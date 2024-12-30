
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.security import APIKeyHeader
from utils.scheduler import scheduler
from config.configmanager import config
from db.dbmanager import execute_db_migration

from tasks.utm_sync_task import *

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
