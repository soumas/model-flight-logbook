import enum
import sqlalchemy

from sqlalchemy import Boolean, Column, Date, DateTime, Enum, ForeignKey, Integer, String
from db.dbmanager import engine

Base = sqlalchemy.orm.declarative_base()

class FlightPlanStatus(enum.Enum):
    created = 'created'
    featureDisabled = 'featureDisabled'
    startPending = 'startPending'
    flying = 'flying'
    endPending = 'endPending'
    closed = 'closed'
    error = 'error'

class PilotEntity(Base):
    __tablename__ = "pilots"
    id = Column(String, primary_key=True, index=True, nullable=False)
    firstname = Column(String, nullable=False)
    lastname = Column(String, nullable=False)
    phonenumber = Column(String, nullable=False)
    email = Column(String, nullable=False)    
    active = Column(Boolean, nullable=False)
    acRegistrationValidTo = Column(Date, nullable=True)    
    acPilotlicenseValidTo = Column(Date, nullable=True)    

class FlightSessionEntity(Base):
    __tablename__ = "flightsessions"
    id = Column(Integer, primary_key=True, autoincrement=True)
    pilotid = Column(Integer, ForeignKey(PilotEntity.id), nullable=False)
    start = Column(DateTime, nullable=False)
    flightplanstatus = Column(Enum(FlightPlanStatus), nullable=False)
    end = Column(DateTime, nullable=True)
    takeoffcount = Column(String, nullable=True)
    comment = Column(String, nullable=True)

