from datetime import datetime
from logging import log
from typing import Annotated
from fastapi import Depends, Security, BackgroundTasks
from fastapi.params import Header
from requests import Session
from sqlalchemy import and_, or_
from api.dtos import EndFlightSessionDTO, FlightSessionStatusDTO
from config.configmanager import config
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key, active_flightsession_found, unknown_pilot, flightsession_not_found, inactive_pilot, utm_action_running
from db.entities import FlightPlanStatus, FlightSessionEntity, PilotEntity
from db.dbmanager import get_db
from utils import logger, utm
from utils.send_mail import send_mail

def __terminalauth(api_key_header:str = Security(api_key_header)):
    if api_key_header == config.logbook.apikey_terminal:
        return api_key_header
    raise invalid_api_key

def __findCurrentFlightSession(pilot_id:str, db:Session):
    return db.query(FlightSessionEntity).filter(and_(FlightSessionEntity.pilot_id == pilot_id, or_(FlightSessionEntity.end == None, FlightSessionEntity.flightplan_status == FlightPlanStatus.flying, FlightSessionEntity.flightplan_status == FlightPlanStatus.start_pending, FlightSessionEntity.flightplan_status == FlightPlanStatus.end_pending ))).first()

def __findPilot(pilot_id:str, db:Session, raiseOnInactive:bool = True):
    logger.log.info('Pilot: ' + pilot_id) # log pilot to know the user related to an uvicorn.access log entry
    pilot:PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilot_id).first()
    if(pilot is None):
        raise unknown_pilot
    if(pilot.active != True and raiseOnInactive == True):
        raise inactive_pilot
    return pilot

@api.get("/terminal/flightsession/status", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilot_id:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilot_id=x_pilot_id, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    return FlightSessionStatusDTO(
        pilotName=pilot.firstname + ' ' + pilot.lastname,
        sessionId=None if fsession == None else fsession.id,
        sessionStarttime=None if fsession == None else fsession.start,
        sessionEndtime=None if fsession == None else fsession.end,
        flightPlanStatus=None if fsession == None else fsession.flightplan_status
    )

@api.post("/terminal/flightsession/start", dependencies=[Security(__terminalauth)], response_model=None)
async def start_flight_session(x_pilot_id:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilot_id=x_pilot_id, db=db)
    if __findCurrentFlightSession(x_pilot_id, db) is not None:
        raise active_flightsession_found
    fsession = FlightSessionEntity()
    fsession.pilot_id = x_pilot_id
    fsession.start = datetime.now()
    fsession.flightplan_status = FlightPlanStatus.new
    db.add(fsession)
    db.commit()

    db.refresh(fsession)
    db.refresh(pilot)

    background_tasks.add_task(utm.start_flight, background_tasks, pilot, fsession)


@api.post("/terminal/flightsession/end", dependencies=[Security(__terminalauth)], response_model=None)
async def end_flight_session(data:EndFlightSessionDTO, x_pilot_id:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilot_id=x_pilot_id, db=db, raiseOnInactive=False) 
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    if(fsession is None):
        raise flightsession_not_found
    if(fsession.flightplan_status == FlightPlanStatus.start_pending or fsession.flightplan_status == FlightPlanStatus.end_pending):
        raise utm_action_running
    fsession.end = datetime.now()
    fsession.takeoffcount = data.takeoffcount
    fsession.comment = data.comment
    db.commit()

    db.refresh(fsession)
    db.refresh(pilot)

    background_tasks.add_task(utm.end_flight, background_tasks, pilot, fsession)

    if(config.logbook.forward_comment and fsession.comment):
        send_mail(
            background_tasks=background_tasks, 
            template_name='admin_notification.html', 
            email_to=config.logbook.admin_email, 
            subject='Anmerkung von Pilot', 
            body={'message':'Der Pilot ' + pilot.firstname + ' ' + pilot.lastname + ' hat folgende Anmerkung im Dronespace Logbook hinterlassen: ' + fsession.comment }
        )
