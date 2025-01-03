import enum

from sqlalchemy import and_
from db.dbmanager import SessionLocal
from db.entities import FlightSessionEntity, PilotEntity
from utils.logger import log
from utils.scheduler import scheduler

class UtmSyncStatus(enum.Enum):
    downtime = 'downtime'
    awaitClearanceForTakeOff = 'awaitClearanceForTakeOff'
    flying = 'flying'
    awaitClearanceToLand = 'awaitClearanceToLand'
    error = 'error'

#@scheduler.scheduled_job('interval', seconds=1)
async def run_utm_sync_task():
    db = SessionLocal()
    try :
        fsession:FlightSessionEntity = db.query(FlightSessionEntity).filter(FlightSessionEntity.endd == id).first()
        # fetch the active flight session with the earliest startdate
        mflOperator:PilotEntity = db.query(FlightSessionEntity).filter(FlightSessionEntity.end == None).first()

        db.commit()
        db.refresh(fsession)
        return fsession
    except:
        db.rollback()
        raise
    finally:
        db.close()
    log.debug("xxxxxxxxxxxxxxxxxxx")