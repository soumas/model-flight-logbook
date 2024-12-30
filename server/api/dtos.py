import datetime
from typing import List, Optional

from pydantic import BaseModel

class PilotDTO(BaseModel):
    id: str
    firstname: str
    lastname: str
    phonenumber: str
    email: str
    active: bool
    acRegistrationValidTo: Optional[datetime.date]=None
    acPilotlicenseValidTo: Optional[datetime.date]=None

class FlightSessionStatusDTO(BaseModel):
    pilotName: str
    sessionId: Optional[int]=None
    sessionStarttime: Optional[datetime.datetime]=None
    infoMessages: Optional[List[str]]=None
    warnMessages: Optional[List[str]]=None
    errorMessages: Optional[List[str]]=None

class EndFlightSessionDTO(BaseModel):
    takeoffcount: Optional[int]=None
    maxAltitude: Optional[int]=None
    airspaceObserver: Optional[bool]=None
    comment: Optional[str]=None

class TerminalConfigDTO(BaseModel):
    terminalid: str
    terminaltype : str
    airportname: str
    terminalname: str
    pilotidinstruction: str