import datetime
import sqlalchemy
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, DateTime
from sqlalchemy.orm import sessionmaker, Session

from config.configmanager import config

 
# Database setup
engine = create_engine(config['sqlalchemy']['url'])
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = sqlalchemy.orm.declarative_base()


# Database model
class User(Base):
    __tablename__ = "users"
    keynumber = Column(String, primary_key=True, index=True, nullable=False)
    firstname = Column(String, nullable=False)
    lastname = Column(String, nullable=False)

class Record(Base):
    __tablename__ = "records"
    keynumber = Column(Integer, ForeignKey(User.keynumber), primary_key=True, nullable=False)
    start = Column(DateTime, default=datetime.datetime.utcnow, primary_key=True, nullable=False)
    end = Column(DateTime(), nullable=True)
    takeoffcount = Column(String, nullable=True)
    comment = Column(String, nullable=True)

# Create tables
Base.metadata.create_all(bind=engine)

# Dependency to get the database session
def get_db():
	db = SessionLocal()
	try:
		yield db
	finally:
		db.close()
