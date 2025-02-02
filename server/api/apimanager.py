
from contextlib import asynccontextmanager
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
    trigger_utm_sync_task()
    # run server
    yield
    # after last request (shutdown event)
    scheduler.shutdown()


api = FastAPI(debug=config.logbook.debug, lifespan=lifespan)
api_key_header = APIKeyHeader(name="x-api-key")
