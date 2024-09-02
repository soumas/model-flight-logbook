from fastapi import FastAPI
from fastapi.security import APIKeyHeader

from utils.logger import *
from config.configmanager import config

api = FastAPI(debug=True)
api_key_header = APIKeyHeader(name="x-api-key")