from datetime import datetime, timedelta
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
from utils.send_mail import send_admin_notification

def __specific_terminalauth(x_terminal:Annotated[str, Header()], api_key_header:str = Security(api_key_header)):
    if not x_terminal in config.terminals:
        raise unknown_terminal       
    if api_key_header != config.terminals[x_terminal].apikey:        
        raise invalid_api_key
    return api_key_header

def __common_terminalauth(api_key_header:str = Security(api_key_header)):
    # verry simple "secuity" for get_terminal_config_list (used by terminal client to get config options before a specific terminal is selected)
    if api_key_header != 'a&feoy!j0diusyJog2':        
        raise invalid_api_key

def __findCurrentFlightSession(pilotid:str, db:Session):
    return db.query(FlightSessionEntity).filter(and_(FlightSessionEntity.pilotid == pilotid, or_(FlightSessionEntity.end == None, FlightSessionEntity.flightplanstatus == FlightPlanStatus.flying, FlightSessionEntity.flightplanstatus == FlightPlanStatus.startPending, FlightSessionEntity.flightplanstatus == FlightPlanStatus.endPending ))).first()

def __findPilot(pilotid:str, db:Session, raiseOnInactive:bool = True):
    logger.log.info('Pilot: ' + pilotid) # log pilot to know the user related to an uvicorn.access log entry
    pilot:PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilotid).first()
    if(pilot is None):
        raise unknown_pilot
    if(pilot.active != True and raiseOnInactive == True):
        raise inactive_pilot
    return pilot

@api.get("/terminal/config/list", dependencies=[Security(__common_terminalauth)], response_model=list[TerminalConfigDTO])
def get_terminal_config_list():
    return [TerminalConfigDTO(
        terminalid=cfg,
        terminaltype=config.terminals[cfg].terminaltype,
        airportname=config.terminals[cfg].airportname,
        terminalname=config.terminals[cfg].terminalname,
        pilotidinstruction=config.terminals[cfg].pilotidinstruction,
    ) for cfg in config.terminals]

@api.get("/terminal/connectioncheck", dependencies=[Security(__specific_terminalauth)])
def check_terminal_connection(x_pilotid:Annotated[str | None, Header()] = None, db:Session = Depends(get_db)):
    # check terminal-id and api-id combination (__terminalauth)
    if(x_pilotid):
        # if pilotid is given (singlemode) this method checks existence of pilot
        __findPilot(pilotid=x_pilotid, db=db, raiseOnInactive=False)

@api.get("/terminal/flightsession/status", dependencies=[Security(__specific_terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilotid:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    
    warnMessages = [];
    erroMessages = [];
    if(pilot.acPilotlicenseValidTo == None):
        erroMessages.append('Bei uns ist kein Drohnenführerschein von dir hinterlegt. Bitte sende den Nachweis an info@msgu.at');
    elif(pilot.acPilotlicenseValidTo < datetime.now().date()):
        erroMessages.append('Dein Drohnenführerschein ist abgelaufen. Bitte erneuere ihn und sende den Nachweis an info@msgu.at');
    elif(pilot.acPilotlicenseValidTo < datetime.now().date() + timedelta(days=30)):
        warnMessages.append('Dein Drohnenführerschein läuft am ' + pilot.acPilotlicenseValidTo.strftime('%d.%m.%Y') + ' ab! Bitte denke daran ihn zu erneuern und den Nachweis an info@msgu.at zu senden.');
    if(pilot.acRegistrationValidTo == None):
        erroMessages.append('Bei uns ist keine Registrierung von dir hinterlegt. Bitte sende den Nachweis an info@msgu.at');
    elif(pilot.acRegistrationValidTo < datetime.now().date()):
        erroMessages.append('Deine Registrierung ist abgelaufen. Bitte erneuere sie und sende den Nachweis an info@msgu.at');
    elif(pilot.acRegistrationValidTo < datetime.now().date() + timedelta(days=30)):
        warnMessages.append('Deine Registrierung läuft am ' + pilot.acRegistrationValidTo.strftime('%d.%m.%Y') + ' ab! Bitte denke daran sie zu erneuern und den Nachweis an info@msgu.at zu senden.');

    return FlightSessionStatusDTO(
        pilotName=pilot.firstname + ' ' + pilot.lastname,
        sessionId=None if fsession == None else fsession.id,
        sessionStarttime=None if fsession == None else fsession.start,
        sessionEndtime=None if fsession == None else fsession.end,
        flightPlanStatus=None if fsession == None else fsession.flightplanstatus,
        #infoMessages=['Hüttenfest am 12.12.2024 nicht verläumen'],
        warnMessages=warnMessages,
        errorMessages=erroMessages,
    )

@api.post("/terminal/flightsession/start", dependencies=[Security(__specific_terminalauth)], response_model=None)
async def start_flightsession(x_pilotid:Annotated[str, Header()], x_terminal:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    if __findCurrentFlightSession(x_pilotid, db) is not None:
        raise active_flightsession_found
    fsession = FlightSessionEntity()
    fsession.pilotid = x_pilotid
    fsession.start = datetime.now()
    fsession.flightplanstatus = FlightPlanStatus.created
    db.add(fsession)
    db.commit()

    db.refresh(fsession)
    db.refresh(pilot)

    background_tasks.add_task(utm.start_flight, background_tasks, pilot, fsession, config.terminals[x_terminal])


@api.post("/terminal/flightsession/end", dependencies=[Security(__specific_terminalauth)], response_model=None)
async def end_flightsession(x_pilotid:Annotated[str, Header()], x_terminal:Annotated[str, Header()], data:EndFlightSessionDTO, background_tasks:BackgroundTasks, db:Session = Depends(get_db)):  
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db, raiseOnInactive=False) 
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    if(fsession is None):
        raise flightsession_not_found
    if(fsession.flightplanstatus == FlightPlanStatus.startPending or fsession.flightplanstatus == FlightPlanStatus.endPending):
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