from fastapi import BackgroundTasks, Depends, Response, Security, status
from requests import Session
from config.configmanager import config
from api.dtos import PilotDTO
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key
from db.entities import PilotEntity
from db.dbmanager import get_db
from utils.send_mail import send_admin_notification


def __adminauth(api_key_header: str = Security(api_key_header)):
    if api_key_header == config.logbook.apikey_admin:
        return api_key_header
    raise invalid_api_key

@api.get("/admin/pilot/list", dependencies=[Security(__adminauth)])
def list_all_pilots(db: Session = Depends(get_db)):
    return db.query(PilotEntity).all()

@api.post("/admin/pilot/create_or_update", dependencies=[Security(__adminauth)], response_model=PilotDTO)
def create_or_update_pilot(pilot: PilotDTO, response: Response, db: Session = Depends(get_db)):
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
        db_pilot.acIsUtmOperator = pilot.acIsUtmOperator
        db_pilot.acRegistrationValidTo = pilot.acRegistrationValidTo
        db_pilot.acPilotlicenseValidTo = pilot.acPilotlicenseValidTo
    db.commit()
    return db_pilot

@api.post("/admin/pilot/deactivate_all", dependencies=[Security(__adminauth)])
def deactivate_all_pilots(db: Session = Depends(get_db)):
    for pilot in db.query(PilotEntity).all():
        pilot.active = False
    db.commit()


@api.get("/admin/admin_notification_test", dependencies=[Security(__adminauth)])
def send_test_admin_notification(background_tasks:BackgroundTasks):
    send_admin_notification(
        background_tasks=background_tasks, 
        subject='Test Admin Notification', 
        body={'message':'Die SMTP Server Konfiguration funktioniert - congrats!'}
    )
