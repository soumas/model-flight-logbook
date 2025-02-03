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

def trigger_utm_sync_task():
    job = scheduler.get_job(job_id='sync_with_utm')
    job.modify(next_run_time=(datetime.now()))

@scheduler.scheduled_job('interval', id='sync_with_utm', max_instances=2, coalesce=True, hours=9999999)
def sync_with_utm():
    # This method is executed a maximum of twice at the same time (max_instances=2)
    # The secode thread has to wait until the first one has finished. So whenever on or more changees occure
    # during long running UTM Sync task, the second thread will do its job with newest data thereafter.
    lock.acquire()
    try:        
        for terminalid in config.terminals:
            try:
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
            except:
                utmSyncStatusDataDict[terminalid].status = UtmSyncStatus.error
    finally:
        lock.release()

@scheduler.scheduled_job('interval', id='force_sync_with_utm', max_instances=1, coalesce=True, hours=9999999)
def force_sync_with_utm():
    for terminalid in config.terminals:
        if terminalid in utmSyncStatusDataDict:
            utmSyncStatusDataDict[terminalid].flightSessionIs = None
    trigger_utm_sync_task()

@scheduler.scheduled_job('interval', id='schedule_next_utm_sync', max_instances=1, minutes=1)
def schedule_next_utm_sync():
    # enqueue taskrun for recreate a flightplan when the old one runs out
    eraliestTriggerDate = None
    for terminalid in config.terminals:
        if terminalid in utmSyncStatusDataDict and utmSyncStatusDataDict[terminalid].flightSessionIs != None:
            createNextFlightPlanTime = utmSyncStatusDataDict[terminalid].flightSessionIs.start + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES + 5)
            while createNextFlightPlanTime < datetime.now():
                createNextFlightPlanTime = createNextFlightPlanTime + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES)
            if(eraliestTriggerDate == None or eraliestTriggerDate > createNextFlightPlanTime):
                eraliestTriggerDate = createNextFlightPlanTime
    if eraliestTriggerDate != None:
        log.debug('schedule force_sync_with_utm at ' + eraliestTriggerDate.strftime('%d.%m.%Y, %H:%M'))
        job = scheduler.get_job(job_id='force_sync_with_utm')
        job.modify(next_run_time=(datetime.now()))

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