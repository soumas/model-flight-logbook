import datetime

from pydantic import BaseModel
from typing import Optional

class PilotDTO(BaseModel):
    id: str
    firstname: str
    lastname: str
    phonenumber: str

class RecordDTO(BaseModel):
    user_id: str
    start: datetime.datetime
    end: Optional[datetime.datetime] = None
    comment: Optional[str] = None
