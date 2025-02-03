from datetime import datetime
from db.entities import FlightSessionEntity, PilotEntity
from tasks.utm_tasks import trigger_utm_sync_task
from utils.logger import log
from utils.scheduler import scheduler
from config.configmanager import TerminalConfig, config

from db.dbmanager import SessionLocal
from utils.send_mail import send_mail

@scheduler.scheduled_job('cron', id='close_all_flightsessions', hour=23, minute=00)
def close_all_flightsessions():
    try:
        for fsession in __findOpenFlightSession():
            __closeFlightSession(fsession)            
            pilot = __findPilot(fsession.pilotid)
            terminalconfig:TerminalConfig = config.terminals[fsession.terminalid]
            send_mail(
                to=pilot.email, 
                bcc=config.logbook.admin_email, 
                subject='⚠ Fehlendes Protokoll (' + fsession.start.strftime('%d.%m.%Y') + ')', 
                body='Hallo ' + pilot.firstname + ' ' + pilot.lastname + '!<br/><br/>Dein Flugtag vom ' + fsession.start.strftime('%d.%m.%Y') + ' (Checkin um ' + fsession.start.strftime('%H:%M') + ' Uhr) am Flugplatz "' + terminalconfig.airportname + '" wurde nicht vollständig protokolliert.<br/><br/><strong>Wichtig!</strong> Bitte schließe künftige Flugtage verlässlich über das MFL Terminal ab, damit wir als Verein durch eine lückenlose Aufzeichnung den gesetzlichen Anforderungen nachkommen können.<br/><br/>Vielen Dank!')
    finally:
        trigger_utm_sync_task()

def __closeFlightSession(fsession:FlightSessionEntity):
    db = SessionLocal()
    try:    
        fsession.end = datetime.now()
        fsession.comment = 'Durch MFL Server geschlossen'
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
