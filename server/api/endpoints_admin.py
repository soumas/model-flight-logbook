from fastapi import Depends, Response, Security, status
from requests import Session
from sqlalchemy.exc import IntegrityError
from config.configmanager import config
from api.dtos import PilotDTO
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key
from db.entities import PilotEntity
from db.dbmanager import get_db


def __adminauth(api_key_header: str = Security(api_key_header)):
    if api_key_header == config.api.apikey_admin:
        return api_key_header
    raise invalid_api_key

@api.get("/pilot/all", dependencies=[Security(__adminauth)])
async def get_all_pilots(db: Session = Depends(get_db)):
    raise Exception('fuck')
    return db.query(PilotEntity).all()

@api.post("/pilot/create_or_update", dependencies=[Security(__adminauth)], response_model=PilotDTO)
async def create_or_update_pilot(pilot: PilotDTO, response: Response, db: Session = Depends(get_db)):
    db_pilot : PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilot.id).first()
    if db_pilot is None:
        db_pilot = PilotEntity(**pilot.model_dump())
        db.add(db_pilot)
        response.status_code = status.HTTP_201_CREATED
    else:
        db_pilot.active = pilot.active
        db_pilot.firstname = pilot.firstname
        db_pilot.lastname = pilot.lastname
        db_pilot.phonenumber = pilot.phonenumber
    db.commit()
    return db_pilot

@api.post("/pilot/deactivate_all", dependencies=[Security(__adminauth)])
async def deactivate_all_pilots(db: Session = Depends(get_db)):
    for pilot in db.query(PilotEntity).all():
        pilot.active = False
    db.commit()
