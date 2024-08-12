from datetime import datetime
from typing import Annotated
from fastapi import Depends, Security, status
from fastapi.params import Header
from requests import Session
from api.dtos import FlightSessionStatusDTO
from config.manager import config
from api.manager import api, api_key_header
from api.exceptions import invalid_api_key, active_session_available, unknown_pilot
from db.entities import FlightPlanStatus, FlightSessionEntity, PilotEntity
from db.manager import get_db

def __terminalauth(api_key_header: str = Security(api_key_header)):
    if api_key_header == config.get('api','apikey_terminal'):
        return api_key_header
    raise invalid_api_key

def __findCurrentFlightSession(pilot_id : str, db: Session):
    return db.query(FlightSessionEntity).filter(FlightSessionEntity.pilot_id == pilot_id).filter(FlightSessionEntity.end is not None).first()

def __findActivePilot(pilot_id : str, db: Session):
    return db.query(PilotEntity).filter(PilotEntity.id == pilot_id).filter(PilotEntity.active == True).first()


@api.get("/flightsession/status", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def get_flightsession_status(x_pilot_id: Annotated[str, Header()], db: Session = Depends(get_db)):
    pilot : PilotEntity = __findActivePilot(x_pilot_id, db)
    if(pilot is None):
        raise unknown_pilot    
    fsession : FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    return FlightSessionStatusDTO(
        pilot_name=pilot.firstname + ' ' + pilot.lastname,
        current_session_id=None if fsession == None else fsession.id,
        current_session_starttime=None if fsession == None else fsession.start,
        flight_plan_status=None
    )


@api.post("/flightsession/start", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def start_flight_session(x_pilot_id: Annotated[str, Header()], db: Session = Depends(get_db)):
    if __findCurrentFlightSession(x_pilot_id, db) is not None:
        raise active_session_available

    fsession = FlightSessionEntity()
    fsession.pilot_id = x_pilot_id
    fsession.start = datetime.now()
    fsession.flightplan_status = FlightPlanStatus.initial if config.getboolean('utm','enable') else FlightPlanStatus.unsupported
    db.add(fsession)
    db.commit()

    return get_flightsession_status(x_pilot_id, db)

@api.post("/flightsession/end", dependencies=[Security(__terminalauth)], response_model=FlightSessionStatusDTO)
def end_flight_session(x_pilot_id: Annotated[str, Header()], db: Session = Depends(get_db)):
    fsession : FlightSessionEntity = __findCurrentFlightSession(x_pilot_id, db)
    if(fsession is None):
        raise item_not_found
    db.add(fsession)
    db.commit()
        
    return get_flightsession_status(x_pilot_id, db)

#    if __findCurrentFlightSession(x_pilot_id, db) is None:
        #raise item_not_found

# def __utml_start_flight(user: PilotDTO):
#     utm_start_flight(
#         username=config.get('utm','username'),
#         password=config.get('utm','password'),
#         airport=config.get('utm','airport'),
#         kml_path=config.get('utm','kml_path'),
#         max_altitude_m=config.get('utm','max_altitude_m'),
#         mtom_g=config.get('utm','mtom_g'),
#         pilot_id=user.id,
#         pilot_firstname=user.firstname,
#         pilot_lastname=user.lastname,
#         pilot_phonenumber=user.phonenumber
#     )

# def __utml_end_flight(id: str):
#     utm_end_flight(
#         username=config.get('utm','username'),
#         password=config.get('utm','password'),
#         pilot_id=id
#     )

# @api.post("/startflight/", response_model=str)
# async def start_flight(user: PilotDTO, background_tasks: BackgroundTasks):
#     if(config.getboolean('utm','enable')):
#         background_tasks.add_task(__utml_start_flight, user)
#         return 'start flight process triggered'
#     else:
#         return 'utm inactive'

# @api.post("/endflight/", response_model=str)
# async def end_flight(id: str, background_tasks: BackgroundTasks):
#     if(config.getboolean('utm','enable')):
#         background_tasks.add_task(__utml_end_flight, id)
#         return 'end flight process triggered'
#     else:
#         return 'utm inactive'
