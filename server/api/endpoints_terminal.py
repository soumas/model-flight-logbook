from datetime import datetime, timedelta
from typing import Annotated
from fastapi import Depends, Security, BackgroundTasks
from fastapi.params import Header
from requests import Session
from sqlalchemy import and_, or_
from api.dtos import EndFlightSessionDTO, FlightSessionStatusDTO, TerminalStatusDTO
from config.configmanager import config
from api.apimanager import api, api_key_header
from api.exceptions import invalid_api_key, active_flightsession_found, unknown_pilot, flightsession_not_found, inactive_pilot, unknown_terminal
from db.entities import FlightSessionEntity, PilotEntity
from db.dbmanager import get_db
from tasks.utm_tasks import UtmSyncStatus, trigger_utm_sync_task
from utils.send_mail import send_mail
from tasks.utm_tasks import utmSyncStatusDataDict

def __specific_terminalauth(x_terminal:Annotated[str, Header()], api_key_header:str = Security(api_key_header)):
    if not x_terminal in config.terminals:
        raise unknown_terminal       
    if api_key_header != config.terminals[x_terminal].apikey:        
        raise invalid_api_key
    return api_key_header

def __findCurrentFlightSession(pilotid:str, db:Session):
    return db.query(FlightSessionEntity).filter(and_(FlightSessionEntity.pilotid == pilotid, FlightSessionEntity.end == None)).first()

def __findPilot(pilotid:str, db:Session):
    pilot:PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilotid).first()
    if(pilot is None):
        raise unknown_pilot
    return pilot

@api.get("/terminal/connectioncheck", dependencies=[Security(__specific_terminalauth)])
def check_terminal_connection(x_pilotid:Annotated[str | None, Header()] = None, db:Session = Depends(get_db)):
    if(x_pilotid):
        # if pilotid is given (singlemode) this method checks existence of pilot
        __findPilot(pilotid=x_pilotid, db=db)

@api.get("/terminal/status", dependencies=[Security(__specific_terminalauth)], response_model=TerminalStatusDTO)
def get_status(x_terminal:Annotated[str, Header()]):
    global utmSyncStatusDataDict    
    state = UtmSyncStatus.unknown if config.utm.enabled else UtmSyncStatus.disabled
    busy = config.utm.enabled
    if x_terminal in utmSyncStatusDataDict:
        state = utmSyncStatusDataDict[x_terminal].status    
        busy = utmSyncStatusDataDict[x_terminal].busy
    return TerminalStatusDTO(utmStatus=state.name, utmBusy=busy)


@api.get("/terminal/flightsession/status", dependencies=[Security(__specific_terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilotid:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    
    infoMessages = []
    #infoMessages = ['Hüttenfest am 12.12.2024 nicht versäumen und sonst auch noch eine ganz lange botschaft. Ich wünsch dir viele Spaß mit dieser langen Meldung Und auch noch drei Zeilenumbürche.']
    warnMessages = []
    erroMessages = []
    if(pilot.active != True):
        erroMessages.append('Konto inaktiv');
    
    if(config.utm.enabled  and pilot.acIsUtmOperator != True):
        warnMessages.append('Keine UTM Freigabeanforderung über dieses Konto')

    if(pilot.acPilotlicenseValidTo == None):
        erroMessages.append('Drohnenführerschein fehlt');
    elif(pilot.acPilotlicenseValidTo < datetime.now().date()):
        erroMessages.append('Drohnenführerschein abgelaufen');
    elif(pilot.acPilotlicenseValidTo < datetime.now().date() + timedelta(days=30)):
        warnMessages.append('Dein Drohnenführerschein läuft am ' + pilot.acPilotlicenseValidTo.strftime('%d.%m.%Y') + ' ab!');
    
    if(pilot.acRegistrationValidTo == None):
        erroMessages.append('Registrierung fehlt');
    elif(pilot.acRegistrationValidTo < datetime.now().date()):
        erroMessages.append('Registrierung abgelaufen');
    elif(pilot.acRegistrationValidTo < datetime.now().date() + timedelta(days=30)):
        warnMessages.append('Deine Registrierung läuft am ' + pilot.acRegistrationValidTo.strftime('%d.%m.%Y') + ' ab!');

    return FlightSessionStatusDTO(
        pilotName=pilot.firstname + ' ' + pilot.lastname,
        sessionId=None if fsession == None else fsession.id,
        sessionStarttime=None if fsession == None else fsession.start,
        sessionEndtime=None if fsession == None else fsession.end,
        infoMessages=infoMessages,
        warnMessages=warnMessages,
        errorMessages=erroMessages,
    )

@api.post("/terminal/flightsession/start", dependencies=[Security(__specific_terminalauth)], response_model=None)
def start_flightsession(x_pilotid:Annotated[str, Header()], x_terminal:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    if(pilot.active != True):
        raise inactive_pilot    
    if __findCurrentFlightSession(x_pilotid, db) is not None:
        raise active_flightsession_found
    fsession = FlightSessionEntity()
    fsession.pilotid = x_pilotid
    fsession.terminalid = x_terminal
    fsession.start = datetime.now()
    db.add(fsession)
    db.commit()
    trigger_utm_sync_task();

@api.post("/terminal/flightsession/end", dependencies=[Security(__specific_terminalauth)], response_model=None)
def end_flightsession(x_pilotid:Annotated[str, Header()], x_terminal:Annotated[str, Header()], data:EndFlightSessionDTO, background_tasks:BackgroundTasks, db:Session = Depends(get_db)):  
    pilot:PilotEntity = __findPilot(pilotid=x_pilotid, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilotid, db)
    if(fsession is None):
        raise flightsession_not_found
    fsession.end = datetime.now()
    fsession.takeoffcount = data.takeoffcount
    fsession.maxAltitude = data.maxAltitude
    fsession.airspaceObserver = data.airspaceObserver
    fsession.comment = data.comment
    db.commit()
    trigger_utm_sync_task()
    
    if(config.logbook.forward_comment and fsession.comment):
        send_mail(
            background_tasks=background_tasks,
            to=config.logbook.admin_email,
            subject='Besonderes Ereignis erfasst', 
            body= pilot.firstname + ' ' + pilot.lastname + ' hat am Flugplatz "' + config.terminals[x_terminal].airportname + '" bei der Protokollierung seines Flugtages folgendes besondere Ereignis angegeben:<br/><br/>' + fsession.comment + '<br><br>Kontaktdaten für Rückfragen:<ul><li><a href="mailto:' + pilot.email + '">' + pilot.email + '</a></li><li><a href="tel:' + pilot.phonenumber + '">' + pilot.phonenumber + '</a></li></ul>'
        )
