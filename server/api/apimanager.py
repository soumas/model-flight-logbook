
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import APIKeyHeader
from fastapi.staticfiles import StaticFiles
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
api.mount("/mfl-admin/", StaticFiles(directory="mfl-admin", html=True), name="mfl-admin")
if(config.logbook.debug):
    api.add_middleware(
        CORSMiddleware,
        allow_origins=["http://localhost:5173"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

api_key_header = APIKeyHeader(name="x-api-key")