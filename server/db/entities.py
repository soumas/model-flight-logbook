import datetime
import sqlalchemy

from sqlalchemy import Column, DateTime, ForeignKey, Integer, String
from db.manager import engine

entityBase = sqlalchemy.orm.declarative_base()

class PilotEntity(entityBase):
    __tablename__ = "pilots"
    id = Column(String, primary_key=True, index=True, nullable=False)
    firstname = Column(String, nullable=False)
    lastname = Column(String, nullable=False)
    phonenumber = Column(String, nullable=False)

class RecordEntity(entityBase):
    __tablename__ = "records"
    pilot_id = Column(Integer, ForeignKey(PilotEntity.id), primary_key=True, nullable=False)
    start = Column(DateTime, primary_key=True, nullable=False)
    end = Column(DateTime(), nullable=True)
    takeoffcount = Column(String, nullable=True)
    comment = Column(String, nullable=True)

# Create tables
entityBase.metadata.create_all(bind=engine)
