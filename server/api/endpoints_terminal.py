from datetime import datetime
from logging import log
from typing import Annotated
from fastapi import Depends, Security, BackgroundTasks
from fastapi.params import Header
from requests import Session
from sqlalchemy import and_, or_
from api.dtos import EndFlightSessionDTO, FlightSessionStatusDTO, TerminalConfigDTO
from config.configmanager import config
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key, active_flightsession_found, unknown_pilot, flightsession_not_found, inactive_pilot, utm_action_running, unknown_terminal
from db.entities import FlightPlanStatus, FlightSessionEntity, PilotEntity
from db.dbmanager import get_db
from utils import logger, utm
from utils.send_mail import send_admin_notification, send_mail

def __terminalauth(api_key_header:str = Security(api_key_header)):
    if api_key_header == config.logbook.apikey_terminal:
        return api_key_header
    raise invalid_api_key

def __findCurrentFlightSession(pilotid:str, db:Session):
    return db.query(FlightSessionEntity).filter(and_(FlightSessionEntity.pilotid == pilotid, or_(FlightSessionEntity.end == None, FlightSessionEntity.flightplanstatus == FlightPlanStatus.flying, FlightSessionEntity.flightplanstatus == FlightPlanStatus.start_pending, FlightSessionEntity.flightplanstatus == FlightPlanStatus.end_pending ))).first()

def __findPilot(pilotid:str, db:Session, raiseOnInactive:bool = True):
    logger.log.info('Pilot: ' + pilotid) # log pilot to know the user related to an uvicorn.access log entry
    pilot:PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilotid).first()
    if(pilot is None):
        raise unknown_pilot
    if(pilot.active != True and raiseOnInactive == True):
        raise inactive_pilot
    return pilot

@api.get("/terminal/config/list", dependencies=[Security(__terminalauth)], response_model=list[TerminalConfigDTO])
def get_terminal_config_list():
    return [TerminalConfigDTO(
        id=cfg,
        type=config.terminals[cfg].type,
        airportname=config.terminals[cfg].airportname,
        terminalname=config.terminals[cfg].terminalname,
        adminpin=config.terminals[cfg].adminpin
    ) for cfg in config.terminals]

@api.get("/terminal/flightsession/status", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilotid:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    return FlightSessionStatusDTO(
        pilotName=pilot.firstname + ' ' + pilot.lastname,
        sessionId=None if fsession == None else fsession.id,
        sessionStarttime=None if fsession == None else fsession.start,
        sessionEndtime=None if fsession == None else fsession.end,
        flightPlanStatus=None if fsession == None else fsession.flightplanstatus
    )

@api.post("/terminal/flightsession/start", dependencies=[Security(__terminalauth)], response_model=None)
async def start_flight_session(x_terminal:Annotated[str, Header()], x_pilotid:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    if not x_terminal in config.terminals:
        raise unknown_terminal    
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    if __findCurrentFlightSession(x_pilotid, db) is not None:
        raise active_flightsession_found
    fsession = FlightSessionEntity()
    fsession.pilotid = x_pilotid
    fsession.start = datetime.now()
    fsession.flightplanstatus = FlightPlanStatus.new
    db.add(fsession)
    db.commit()

    db.refresh(fsession)
    db.refresh(pilot)

    background_tasks.add_task(utm.start_flight, background_tasks, pilot, fsession, config.terminals[x_terminal])


@api.post("/terminal/flightsession/end", dependencies=[Security(__terminalauth)], response_model=None)
async def end_flight_session(x_terminal:Annotated[str, Header()], x_pilotid:Annotated[str, Header()], data:EndFlightSessionDTO, background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    if not x_terminal in config.terminals:
        raise unknown_terminal      
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db, raiseOnInactive=False) 
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    if(fsession is None):
        raise flightsession_not_found
    if(fsession.flightplanstatus == FlightPlanStatus.start_pending or fsession.flightplanstatus == FlightPlanStatus.end_pending):
        raise utm_action_running
    fsession.end = datetime.now()
    fsession.takeoffcount = data.takeoffcount
    fsession.comment = data.comment
    db.commit()

    db.refresh(fsession)
    db.refresh(pilot)
    
    background_tasks.add_task(utm.end_flight, background_tasks, pilot, fsession, config.terminals[x_terminal])

    if(config.logbook.forward_comment and fsession.comment):
        send_admin_notification(
            background_tasks=background_tasks, 
            subject='Anmerkung von Pilot', 
            body={'message':'Der Pilot ' + pilot.firstname + ' ' + pilot.lastname + ' hat folgende Anmerkung im Model Flight Logbook hinterlassen: ' + fsession.comment }
        )