from fastapi import BackgroundTasks, Depends, HTTPException, Response, Security, status
from requests import Session
from config.configmanager import config
from api.dtos import FlightSessionDTO, PilotDTO
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key
from db.entities import FlightSessionEntity, PilotEntity
from db.dbmanager import get_db
from tasks.utm_tasks import trigger_utm_sync_task
from utils.dbutils import commit_with_httpexceptionhandling
from utils.send_mail import send_mail


def __adminauth(api_key_header: str = Security(api_key_header)):
    if api_key_header == config.logbook.apikey_admin:
        return api_key_header
    raise invalid_api_key

############################ PILOT ################################

@api.get("/admin/pilot", dependencies=[Security(__adminauth)],response_model=list[PilotDTO])
def get_all_pilots(db: Session = Depends(get_db)):
    return db.query(PilotEntity).all()

@api.get("/admin/pilot/{id}", dependencies=[Security(__adminauth)],response_model=PilotDTO)
def get_pilot(id: str, db: Session = Depends(get_db)):
    db_pilot : PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == id).first()
    if db_pilot is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    else:
        return db_pilot

@api.delete("/admin/pilot/{id}", dependencies=[Security(__adminauth)])
def delete_pilot(id: str, db: Session = Depends(get_db)):
    db.query(FlightSessionEntity).filter(FlightSessionEntity.pilotid == id).delete()
    db.query(PilotEntity).filter(PilotEntity.id == id).delete()
    commit_with_httpexceptionhandling(db)

@api.post("/admin/pilot", dependencies=[Security(__adminauth)], response_model=PilotDTO)
def create_pilot(pilot: PilotDTO, db: Session = Depends(get_db)):
    db_pilot = PilotEntity(**pilot.model_dump())
    db.add(db_pilot)
    commit_with_httpexceptionhandling(db)
    return db_pilot

@api.put("/admin/pilot/{id}", dependencies=[Security(__adminauth)], response_model=PilotDTO)
def update_pilot(id: str, pilot: PilotDTO, db: Session = Depends(get_db)):
    db_pilot : PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == id).first()
    if db_pilot is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    else:
        if pilot.id != id:
            for fsess in db.query(FlightSessionEntity).filter(FlightSessionEntity.pilotid == id).all():
                fsess.pilotid = pilot.id
                db.add(fsess)
        db_pilot.id = pilot.id
        db_pilot.active = pilot.active
        db_pilot.firstname = pilot.firstname
        db_pilot.lastname = pilot.lastname
        db_pilot.phonenumber = pilot.phonenumber
        db_pilot.acRegistrationValidTo = pilot.acRegistrationValidTo
        db_pilot.validateAcRegistration = pilot.validateAcRegistration
        db_pilot.acPilotlicenseValidTo = pilot.acPilotlicenseValidTo
        db_pilot.validateAcPilotlicense = pilot.validateAcPilotlicense
        db_pilot.infoMessages = pilot.infoMessages
        db_pilot.warnMessages = pilot.warnMessages
        db_pilot.errorMessages = pilot.errorMessages
        db.add(db_pilot)
        commit_with_httpexceptionhandling(db)
        return db_pilot


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
        db_pilot.acRegistrationValidTo = pilot.acRegistrationValidTo
        db_pilot.validateAcRegistration = pilot.validateAcRegistration
        db_pilot.acPilotlicenseValidTo = pilot.acPilotlicenseValidTo
        db_pilot.validateAcPilotlicense = pilot.validateAcPilotlicense
        db_pilot.infoMessages = pilot.infoMessages
        db_pilot.warnMessages = pilot.warnMessages
        db_pilot.errorMessages = pilot.errorMessages
    commit_with_httpexceptionhandling(db)
    return db_pilot

@api.post("/admin/pilot/deactivate_all", dependencies=[Security(__adminauth)])
def deactivate_all_pilots(db: Session = Depends(get_db)):
    for pilot in db.query(PilotEntity).all():
        pilot.active = False
    commit_with_httpexceptionhandling(db)

########################### FLIGHT SESSIONS ################################

@api.get("/admin/flightsession/{year}", dependencies=[Security(__adminauth)],response_model=list[FlightSessionDTO])
def get_all_flightsessions(year: int, db: Session = Depends(get_db)):
    sessions : list[FlightSessionEntity] =  db.query(FlightSessionEntity).filter(FlightSessionEntity.start.between('{:04d}-01-01'.format(year),'{:04d}-12-31'.format(year))).all()
    pilots : list[PilotEntity] = db.query(PilotEntity).filter(PilotEntity.id.in_(dict.fromkeys([o.pilotid for o in sessions]))).all()
    for session in sessions:
        pilot = [p for p in pilots if p.id == session.pilotid ][0]
        session.pilotname = pilot.lastname + ' ' + pilot.firstname
        session.airport =  config.terminals[session.terminalid].airportname if session.terminalid in config.terminals.keys() else 'Unbekannt'
    return sessions

########################### OTHERS #########################################

@api.get("/admin/admin_notification_test", dependencies=[Security(__adminauth)])
def send_test_admin_notification(background_tasks:BackgroundTasks):
    send_mail(
        background_tasks=background_tasks, 
        to=config.logbook.admin_email,
        subject='Test Admin Notification', 
        body='Der SMTP Server wurde korrekt konfiguriert'
    )

@api.get("/admin/checkauth", dependencies=[Security(__adminauth)])
def list_all_pilots(db: Session = Depends(get_db)):
    return "OK"

@api.get("/admin/trigger_utm_sync", dependencies=[Security(__adminauth)])
def trigger_utm_sync(db: Session = Depends(get_db)):
    trigger_utm_sync_task()