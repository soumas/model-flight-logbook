# Import necessary modules and classes
import datetime
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, DateTime
import sqlalchemy
from sqlalchemy.orm import sessionmaker, Session
from pydantic import BaseModel
from typing import Optional

TODO:
https://fastapi.tiangolo.com/tutorial/security/get-current-user/

# FastAPI app instance
app = FastAPI()
 
# Database setup
DATABASE_URL = "sqlite:///./data.db"
engine = create_engine(DATABASE_URL)
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

# Pydantic model for response data
class UserDTO(BaseModel):
    keynumber: str
    firstname: str
    lastname: str

class RecordDTO(BaseModel):
    keynumber: str
    start: datetime.datetime
    end: Optional[datetime.datetime] = None
    takeoffcount: Optional[str] = None
    comment: Optional[str] = None

# API endpoint to create an item
@app.post("/records/", response_model=RecordDTO)
async def create_record(data: RecordDTO, db: Session = Depends(get_db)):
    record = Record(**data.model_dump())
    db.add(record)
    db.commit()
    db.refresh(record)
    return record

# API endpoint to create an item
@app.post("/users/", response_model=UserDTO)
async def create_user(user: UserDTO, db: Session = Depends(get_db)):
    db_user = User(**user.model_dump())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# API endpoint to read all users
@app.get("/users/", response_model=list[UserDTO])
async def get_all_users(db: Session = Depends(get_db)):
    return db.query(User).all()

# API endpoint to read an item by ID
@app.get("/users/{user_id}", response_model=UserDTO)
async def read_user(user_id: str, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.keynumber == user_id).first()
    if db_user is None:
        raise HTTPException(status_code=404, detail="Item not found")
    return db_user


if __name__ == "__main__":
	import uvicorn
	uvicorn.run(app, host="127.0.0.1", port=8000)
