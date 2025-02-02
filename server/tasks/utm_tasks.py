from datetime import datetime, timedelta
import enum
import threading

from sqlalchemy import and_
from db.dbmanager import SessionLocal
from db.entities import FlightSessionEntity, PilotEntity
from config.configmanager import TerminalConfig, config
from utils.logger import log
from utils.scheduler import scheduler
from utils.utm import UTM_FLIGHTPLAN_DURATION_MINUTES, update_utm_operator

class UtmSyncStatus(enum.Enum):
     unknown = 'unknown'
     noActiveFlight = 'noActiveFlight'
     flying = 'flying'
     error = 'error'

class UtmSyncStatusData:
    def __init__(self):
        self.status:UtmSyncStatus = UtmSyncStatus.unknown
        self.busy:bool = False
        self.flightSessionShould:FlightSessionEntity = None
        self.flightSessionIs:FlightSessionEntity = None

lock = threading.Lock()
utmSyncStatusDataDict:dict = {}

def trigger_utm_sync_task(time:datetime = None):
    job = scheduler.get_job(job_id='sync_with_utm')
    job.modify(next_run_time=(time if time is not None else datetime.now()))


@scheduler.scheduled_job('interval', id='sync_with_utm', max_instances=2, coalesce=True, hours=9999999)
def sync_with_utm():
    # This method is executed a maximum of twice at the same time (max_instances=2)
    # The secode thread has to wait until the first one has finished. So whenever on or more changees occure
    # during long running UTM Sync task, the second thread will do its job with newest data thereafter.
    lock.acquire()
    try:        
        for terminalid in config.terminals:
            try:
                log.debug('Handling terminal with id ' + terminalid)

                if not terminalid in utmSyncStatusDataDict:
                    utmSyncStatusDataDict[terminalid] = UtmSyncStatusData()

                utmSyncStatusDataDict[terminalid].flightSessionShould=__findRelevantFlightSession(terminalid)

                if(utmSyncStatusDataDict[terminalid].flightSessionShould is None):
                    log.debug('No relevant FlightSession found for Terminal ' + terminalid)
                    if(utmSyncStatusDataDict[terminalid].status != UtmSyncStatus.noActiveFlight):
                        __updateUtmOperator(config.terminals[terminalid], None)
                        utmSyncStatusDataDict[terminalid].flightSessionIs = None
                else:
                    pilotIDShould = utmSyncStatusDataDict[terminalid].flightSessionShould.pilotid
                    pilotIDIs = utmSyncStatusDataDict[terminalid].flightSessionIs.pilotid if utmSyncStatusDataDict[terminalid].flightSessionIs != None else None
                    log.debug('pilotIDShould: ' + str(pilotIDShould))
                    log.debug('pilotIDIs: ' + str(pilotIDIs))
                    if(pilotIDShould != pilotIDIs):
                        __updateUtmOperator(config.terminals[terminalid], utmSyncStatusDataDict[terminalid].flightSessionShould.pilotid)
                        utmSyncStatusDataDict[terminalid].flightSessionIs = utmSyncStatusDataDict[terminalid].flightSessionShould                        
                    else:
                        log.debug('MFL and UTM are in sync')

                # enqueue taskrun for the case a pilot is longer active as 4 hours
                if(utmSyncStatusDataDict[terminalid].flightSessionIs != None):
                    utmEndTime = utmSyncStatusDataDict[terminalid].flightSessionIs.start + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES + 2)
                    trigger_utm_sync_task(time=utmEndTime)
            except:
                utmSyncStatusDataDict[terminalid].status = UtmSyncStatus.error
    finally:
        lock.release()

def __updateUtmOperator(config:TerminalConfig, pilotid:str | None):
    utmSyncStatusDataDict[config.terminalid].busy = True
    try:
        flying = update_utm_operator(config.airportname, config.airportkml, None if pilotid is None else __findPilot(pilotid))
        utmSyncStatusDataDict[config.terminalid].status = UtmSyncStatus.flying if flying else UtmSyncStatus.noActiveFlight
    finally:
        utmSyncStatusDataDict[config.terminalid].busy = False

def __findRelevantFlightSession(terminalid:str):
    # fetch the active flight session with the earliest startdate and an utm-operator pilot
    db = SessionLocal()
    try:
        return db.query(FlightSessionEntity).join(PilotEntity).filter(and_(FlightSessionEntity.end == None, FlightSessionEntity.terminalid == terminalid, PilotEntity.acIsUtmOperator == True)).order_by(FlightSessionEntity.start).first()
    except:
        db.rollback()
        raise
    finally:
        db.close()

def __findPilot(pilotid:str):
    db = SessionLocal()
    try:
        return db.query(PilotEntity).filter(PilotEntity.id == pilotid).first()
    except:
        db.rollback()
        raise
    finally:
        db.close()