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
    acIsUtmOperator: bool
    acRegistrationValidTo: Optional[datetime.date]=None
    acPilotlicenseValidTo: Optional[datetime.date]=None

class FlightSessionDTO(BaseModel):
    id: int
    pilotid: str
    terminalid: str
    start: datetime.datetime
    end: Optional[datetime.datetime]=None
    takeoffcount: Optional[int]=None
    maxAltitude: Optional[int]=None
    airspaceObserver: Optional[bool]=None
    comment: Optional[str]=None 

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
    maxAltitudeM: str
    maxNumFlights: str

class TerminalStatusDTO(BaseModel):
    utmStatus: str
    utmBusy: bool
    