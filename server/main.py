from config.configmanager import config
from db.dbmanager import get_db, Session, User, Record

# Import necessary modules and classes
import datetime
from fastapi import FastAPI, Depends, HTTPException

from pydantic import BaseModel
from typing import Optional




#TODO:
#https://fastapi.tiangolo.com/tutorial/security/get-current-user/

# FastAPI app instance
app = FastAPI()


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
	uvicorn.run(app, host=config['api']['hostname'], port=int(config['api']['port']))
