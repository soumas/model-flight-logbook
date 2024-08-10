# FastAPI app instance
from typing import Annotated
from requests import Session
from fastapi import BackgroundTasks, FastAPI, Depends
from fastapi.security import OAuth2PasswordBearer

from api.dtos import RecordDTO, PilotDTO
from db.entities import RecordEntity, PilotEntity
from db.manager import get_db
from config.manager import *

from features.utm import utm_start_flight, utm_end_flight

api = FastAPI()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# API endpoint to create an item
@api.post("/users/", response_model=PilotDTO)
async def create_user(token: Annotated[str, Depends(oauth2_scheme)], user: PilotDTO, db: Session = Depends(get_db)):
    db_user = PilotEntity(**user.model_dump())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# # API endpoint to create an item
# @api.post("/records/", response_model=RecordDTO)
# async def create_record(data: RecordDTO, db: Session = Depends(get_db)):
#     record = RecordEntity(**data.model_dump())
#     db.add(record)
#     db.commit()
#     db.refresh(record)
#     return record

# # API endpoint to create an item
# @api.post("/users/", response_model=PilotDTO)
# async def create_user(user: PilotDTO, db: Session = Depends(get_db)):
#     db_user = PilotEntity(**user.model_dump())
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user

# # API endpoint to read all users
# @api.get("/users/", response_model=list[PilotDTO])
# async def get_all_users(db: Session = Depends(get_db)):
#     return db.query(PilotEntity).all()

# # API endpoint to read an item by ID
# @api.get("/users/{user_id}", response_model=PilotDTO)
# async def read_user(user_id: str, db: Session = Depends(get_db)):
#     db_user = db.query(PilotEntity).filter(PilotEntity.id == user_id).first()
#     if db_user is None:
#         raise HTTPException(status_code=404, detail="Item not found")
#     return db_user


def __utml_start_flight(user: PilotDTO):
    utm_start_flight(
        username=config.get('utm','username'),
        password=config.get('utm','password'),
        airport=config.get('utm','airport'),
        kml_path=config.get('utm','kml_path'),
        max_altitude_m=config.get('utm','max_altitude_m'),
        mtom_g=config.get('utm','mtom_g'),
        pilot_id=user.id,
        pilot_firstname=user.firstname,
        pilot_lastname=user.lastname,
        pilot_phonenumber=user.phonenumber
    )

def __utml_end_flight(id: str):
    utm_end_flight(
        username=config.get('utm','username'),
        password=config.get('utm','password'),
        pilot_id=id
    )

@api.post("/startflight/", response_model=str)
async def start_flight(user: PilotDTO, background_tasks: BackgroundTasks):
    if(config.getboolean('utm','enable')):
        background_tasks.add_task(__utml_start_flight, user)
        return 'start flight process triggered'
    else:
        return 'utm inactive'

@api.post("/endflight/", response_model=str)
async def end_flight(id: str, background_tasks: BackgroundTasks):
    if(config.getboolean('utm','enable')):
        background_tasks.add_task(__utml_end_flight, id)
        return 'end flight process triggered'
    else:
        return 'utm inactive'

#TODO:
#https://fastapi.tiangolo.com/tutorial/security/get-current-user/
