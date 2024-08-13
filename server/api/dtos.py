import datetime
from typing import Optional

from pydantic import BaseModel
from sqlalchemy import DateTime

from db.entities import FlightPlanStatus

class PilotDTO(BaseModel):
    id: str
    firstname: str
    lastname: str
    phonenumber: str
    active: bool

class FlightSessionStatusDTO(BaseModel):
    pilot_name: str
    current_session_id: Optional[int]=None
    current_session_starttime: Optional[datetime.datetime]=None
    flight_plan_status: Optional[FlightPlanStatus]=None

class EndFlightSessionDTO(BaseModel):
    takeoffcount: Optional[int]=None
    comment: Optional[str]=None
