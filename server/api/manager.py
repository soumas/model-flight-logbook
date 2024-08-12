from fastapi import FastAPI
from fastapi.security import APIKeyHeader


api = FastAPI()
api_key_header = APIKeyHeader(name="x-api-key", auto_error=False)