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
     disabled = 'disabled'
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
utmSyncErrorCount = 0

def trigger_utm_sync_task():
    job = scheduler.get_job(job_id='sync_with_utm')
    job.modify(next_run_time=(datetime.now()))

@scheduler.scheduled_job('interval', id='sync_with_utm', max_instances=2, coalesce=True, hours=9999999)
def sync_with_utm():

    if(config.utm.enabled != True):
        return

    global utmSyncErrorCount
    # This method is executed twice the same time at maximum (max_instances=2)
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
                utmSyncErrorCount = utmSyncErrorCount + 1
    finally:
        lock.release()

@scheduler.scheduled_job('interval', id='utm_sync_scheduler', max_instances=1, minutes=1)
def utm_sync_scheduler():

    if(config.utm.enabled != True):
        scheduler.remove_job('utm_sync_scheduler')
        return

    # check if any state is unknown (usually after server start)
    for terminalid in config.terminals:
        if terminalid not in utmSyncStatusDataDict or utmSyncStatusDataDict[terminalid].status == UtmSyncStatus.unknown:
            log.debug(msg='State of terminal ' + terminalid + ' is unknown --> trigger_utm_sync_task')
            trigger_utm_sync_task()
            return
        
    # retrigger utm sync if any state is error
    for terminalid in config.terminals:
        if terminalid in utmSyncStatusDataDict and utmSyncStatusDataDict[terminalid].status == UtmSyncStatus.error:
            if utmSyncErrorCount  < 3:
                log.warning(msg='utmSyncErrorCount is ' + str(utmSyncErrorCount) + ', next try now')
                trigger_utm_sync_task()
            else:
                log.warning(msg='utmSyncErrorCount is ' + str(utmSyncErrorCount) + ', next try in one hour')
                job = scheduler.get_job(job_id='utm_sync_scheduler')
                job.modify(next_run_time=datetime.now() + timedelta(minutes=60))
            return

    # everything is fine but it could be that a pilot is longer active as the maximum flightplan duration (UTM_FLIGHTPLAN_DURATION_MINUTES)
    eraliestTriggerDate = None
    for terminalid in config.terminals:
        if terminalid in utmSyncStatusDataDict and utmSyncStatusDataDict[terminalid].flightSessionIs != None:
            createNextFlightPlanTime = utmSyncStatusDataDict[terminalid].flightSessionIs.start + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES + 5)
            while createNextFlightPlanTime < datetime.now():
                createNextFlightPlanTime = createNextFlightPlanTime + timedelta(minutes=UTM_FLIGHTPLAN_DURATION_MINUTES + 5)
            if(eraliestTriggerDate == None or eraliestTriggerDate > createNextFlightPlanTime):
                eraliestTriggerDate = createNextFlightPlanTime
    if eraliestTriggerDate != None:
        log.debug('schedule force_sync_with_utm at ' + eraliestTriggerDate.strftime('%d.%m.%Y, %H:%M'))
        job = scheduler.get_job(job_id='force_sync_with_utm')
        job.modify(next_run_time=eraliestTriggerDate)


@scheduler.scheduled_job('interval', id='force_sync_with_utm', max_instances=1, coalesce=True, hours=9999999)
def force_sync_with_utm():
    global utmSyncErrorCount
    for terminalid in config.terminals:
        if terminalid in utmSyncStatusDataDict:
            utmSyncStatusDataDict[terminalid].flightSessionIs = None
    trigger_utm_sync_task()

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
        return db.query(FlightSessionEntity).join(PilotEntity).filter(and_(FlightSessionEntity.end == None, FlightSessionEntity.terminalid == terminalid, PilotEntity.validateAcRegistration == True)).order_by(FlightSessionEntity.start).first()
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