import enum
import sqlalchemy

from sqlalchemy import Boolean, Column, DateTime, Enum, ForeignKey, Integer, String
from db.manager import engine

Base = sqlalchemy.orm.declarative_base()

class FlightPlanStatus(enum.Enum):
    unsupported = 'unsupported'
    initial = 'initial'
    pending = 'pending'
    active = 'active'
    closed = 'closed'
    error = 'error'

class PilotEntity(Base):
    __tablename__ = "pilots"
    id = Column(String, primary_key=True, index=True, nullable=False)
    firstname = Column(String, nullable=False)
    lastname = Column(String, nullable=False)
    phonenumber = Column(String, nullable=False)
    active = Column(Boolean, nullable=False)

class FlightSessionEntity(Base):
    __tablename__ = "flightsessions"
    id = Column(Integer, primary_key=True, autoincrement=True)
    pilot_id = Column(Integer, ForeignKey(PilotEntity.id), nullable=False)
    start = Column(DateTime, nullable=False)
    flightplan_status = Column(Enum(FlightPlanStatus), nullable=False)
    end = Column(DateTime, nullable=True)
    takeoffcount = Column(String, nullable=True)
    comment = Column(String, nullable=True)


# Create tables
Base.metadata.create_all(bind=engine)
