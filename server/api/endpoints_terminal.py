from datetime import datetime
import time
import traceback
from typing import Annotated
from fastapi import Depends, Security, BackgroundTasks
from fastapi.params import Header
from requests import Session
from sqlalchemy import and_
from api.dtos import EndFlightSessionDTO, FlightSessionStatusDTO
from config.manager import config
from api.manager import api, api_key_header
from api.exceptions import invalid_api_key, active_flightsession_found, unknown_pilot, flightsession_not_found, inactive_pilot, utm_action_running
from db.entities import FlightPlanStatus, FlightSessionEntity, PilotEntity
from db.manager import get_db, SessionLocal
from features.send_mail import send_mail

def __terminalauth(api_key_header:str = Security(api_key_header)):
    if api_key_header == config.get('api','apikey_terminal'):
        return api_key_header
    raise invalid_api_key

def __findCurrentFlightSession(pilot_id:str, db:Session):
    return db.query(FlightSessionEntity).filter(and_(FlightSessionEntity.pilot_id == pilot_id, FlightSessionEntity.end == None)).first()

def __findPilot(pilot_id:str, db:Session):
    pilot:PilotEntity = db.query(PilotEntity).filter(PilotEntity.id == pilot_id).first()
    if(pilot is None):
        raise unknown_pilot
    if(pilot.active != True):
        raise inactive_pilot
    return pilot

def __set_flightplan_status(id:int, status:FlightPlanStatus):
    db = SessionLocal()
    try :
        fsession:FlightSessionEntity = db.query(FlightSessionEntity).filter(FlightSessionEntity.id == id).first()
        fsession.flightplan_status = status
        db.commit()
    except:
        db.rollback()
        raise
    finally:
        db.close()

def __start_utm_task(fsession:FlightSessionEntity, target_status:FlightPlanStatus):
    __set_flightplan_status(id=fsession.id, status=FlightPlanStatus.pending)
    try:
        if target_status == FlightPlanStatus.active: 
            time.sleep(30) # todo utm
            # utm_start_flight(
            #     username=config.get('utm','username'),
            #     password=config.get('utm','password'),
            #     airport=config.get('utm','airport'),
            #     kml_path=config.get('utm','kml_path'),
            #     max_altitude_m=config.get('utm','max_altitude_m'),
            #     mtom_g=config.get('utm','mtom_g'),
            #     pilot_id=user.id,
            #     pilot_firstname=user.firstname,
            #     pilot_lastname=user.lastname,
            #     pilot_phonenumber=user.phonenumber
            # )
        elif target_status == FlightPlanStatus.closed:
            time.sleep(20) # todo utm 
            # utm_end_flight(
            #     username=config.get('utm','username'),
            #     password=config.get('utm','password'),
            #     pilot_id=id
            # )
        __set_flightplan_status(id=fsession.id, status=FlightPlanStatus.active)
    except:
        traceback.print_exc()
        __set_flightplan_status(id=fsession.id, status=FlightPlanStatus.error)


@api.get("/flightsession/status", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilot_id:Annotated[str, Header()], db:Session = Depends(get_db)):
    pilot:PilotEntity = __findPilot(pilot_id=x_pilot_id, db=db)
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    return FlightSessionStatusDTO(
        pilot_name=pilot.firstname + ' ' + pilot.lastname,
        current_session_id=None if fsession == None else fsession.id,
        current_session_starttime=None if fsession == None else fsession.start,
        flight_plan_status=None if fsession == None else fsession.flightplan_status
    )

@api.post("/flightsession/start", dependencies=[Security(__terminalauth)], response_model=None)
async def start_flight_session(x_pilot_id:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    # make sure the request comes from an active pilot
    __findPilot(pilot_id=x_pilot_id, db=db)
    if __findCurrentFlightSession(x_pilot_id, db) is not None:
        raise active_flightsession_found
    fsession = FlightSessionEntity()
    fsession.pilot_id = x_pilot_id
    fsession.start = datetime.now()
    fsession.flightplan_status = FlightPlanStatus.initial if config.getboolean('utm','enable') else FlightPlanStatus.unsupported
    #db.add(fsession)
    #db.commit()
    send_mail(background_tasks=background_tasks, subject='Testnachricht', email_to='office@soumasoft.com', body={'title':'Hello World', 'name':'John Doe'})
    # if config.getboolean('utm','enable'):
    #     background_tasks.add_task(__start_utm_task, fsession, FlightPlanStatus.active)


@api.post("/flightsession/end", dependencies=[Security(__terminalauth)], response_model=None)
async def end_flight_session(data:EndFlightSessionDTO, x_pilot_id:Annotated[str, Header()], background_tasks:BackgroundTasks, db:Session = Depends(get_db)):
    # do not ensure activity of pilot because it should always be possible to end an active fligthsession    
    fsession:FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    if(fsession is None):
        raise flightsession_not_found
    if(fsession.flightplan_status == FlightPlanStatus.pending):
        raise utm_action_running
    fsession.end = datetime.now()
    fsession.takeoffcount = data.takeoffcount
    fsession.comment = data.comment
    db.commit()
    # if config.getboolean('utm','enable'):
    #     background_tasks.add_task(__start_utm_task, fsession, FlightPlanStatus.closed)
