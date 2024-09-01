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
    email: str
    active: bool

class FlightSessionStatusDTO(BaseModel):
    pilotName: str
    sessionId: Optional[int]=None
    sessionStarttime: Optional[datetime.datetime]=None
    sessionEndtime: Optional[datetime.datetime]=None
    flightPlanStatus: Optional[FlightPlanStatus]=None

class EndFlightSessionDTO(BaseModel):
    takeoffcount: Optional[int]=None
    comment: Optional[str]=None
