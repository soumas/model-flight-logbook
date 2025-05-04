from datetime import datetime, timedelta
import os
from db.entities import FlightSessionEntity, PilotEntity
from tasks.utm_tasks import trigger_utm_sync_task
from utils.logger import log
from utils.operatinghours_utils import findOperatinghourDayDefinition, isInOperatinghour
from utils.scheduler import scheduler
from config.configmanager import TerminalConfig, config

from db.dbmanager import SessionLocal
from utils.send_mail import send_mail

lastSoonestOperatinghoursEnd = None

@scheduler.scheduled_job('interval', id='close_all_flightsessions_scheduler', max_instances=1, coalesce=True, minutes=1)
def close_all_flightsessions_scheduler():
    global lastSoonestOperatinghoursEnd
    soonestOperatinghoursEnd = None
    now = datetime.now()    
    for terminalid in config.terminals:
        operatingHourDayDefinition = findOperatinghourDayDefinition(terminalid, now)
        if operatingHourDayDefinition != None:
            if soonestOperatinghoursEnd == None or soonestOperatinghoursEnd > operatingHourDayDefinition.end:
                soonestOperatinghoursEnd = operatingHourDayDefinition.end
    
    if soonestOperatinghoursEnd != None:
        job = scheduler.get_job(job_id='close_all_flightsessions')
        if lastSoonestOperatinghoursEnd == None:
            # always execute close_all_flightsessions at the first cycle to ensure a valid state
            job.modify(next_run_time=datetime.now())
            lastSoonestOperatinghoursEnd = datetime.now()
        elif soonestOperatinghoursEnd > now and soonestOperatinghoursEnd != lastSoonestOperatinghoursEnd:
            job.modify(next_run_time=soonestOperatinghoursEnd)
            lastSoonestOperatinghoursEnd = soonestOperatinghoursEnd
    else:
        # cancel this task if there are no operatinghours defined at all        
        scheduler.remove_job('close_all_flightsessions_scheduler')
        return

@scheduler.scheduled_job('interval', id='close_all_flightsessions', max_instances=1, coalesce=True, minutes=9999999)
def close_all_flightsessions():
    try:
        now = datetime.now()
        for fsession in __findOpenFlightSession():
            operatingHourDayDefinition = findOperatinghourDayDefinition(fsession.terminalid, now)
            if operatingHourDayDefinition != None and not isInOperatinghour(operatingHourDayDefinition, now):
                __closeFlightSession(fsession, operatingHourDayDefinition.end)
                pilot = __findPilot(fsession.pilotid)
                terminalconfig:TerminalConfig = config.terminals[fsession.terminalid]
                send_mail(
                    to=pilot.email, 
                    bcc=config.logbook.admin_email, 
                    subject='⚠ Aktiver Flugtag außerhalb der Öffnungszeit', 
                    body='Hallo ' + pilot.firstname + ' ' + pilot.lastname + '!<br/><br/>Dein Flugtag vom ' + fsession.start.strftime('%d.%m.%Y') + ' (Checkin um ' + fsession.start.strftime('%H:%M') + ' Uhr) am Flugplatz "' + terminalconfig.airportname + '" wurde nicht vor Betriebsende (' + operatingHourDayDefinition.end.strftime('%H:%M') + ' Uhr) protokolliert und geschlossen.<br/><br/><strong>Wichtig!</strong> Bitte protokolliere und schließe künftige Flugtage verlässlich über das MFL Terminal bevor du den Flugplatz verlässt, damit wir als Verein durch eine lückenlose Aufzeichnung den gesetzlichen Anforderungen nachkommen können.<br/>')
    finally:
        trigger_utm_sync_task()

def __closeFlightSession(fsession:FlightSessionEntity, end:datetime):
    db = SessionLocal()
    try:    
        fsession.end = end
        fsession.endedby = 'sys'
        db.merge(fsession)
        db.commit() 
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

def __findOpenFlightSession():
    db = SessionLocal()
    try:
        return db.query(FlightSessionEntity).filter(FlightSessionEntity.end == None)
    except:
        db.rollback()
        raise
    finally:
        db.close()
