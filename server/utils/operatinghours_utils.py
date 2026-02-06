from datetime import datetime, timedelta, timezone
from utils.logger import log
import re
import traceback
from config.configmanager import config
import csv

_operatinghourstimeregex = r"^(?P<hours>\d{2})\:(?P<minutes>\d{2})\:(?P<seconds>\d{2})$"
_operatinghoursCache:dict = {}

class OperatingHourDayDefinition:
    def __init__(self, start:datetime, end:datetime):
        self.start : datetime = start
        self.end : datetime = end

    def applyYear(self, year:int):
        self.start = self.start.replace(year=year)
        self.end = self.end.replace(year=year)        

def findOperatinghourDayDefinition(terminalid:str, refdate:datetime):
    if not _operatinghourCheckEnabled(terminalid):
        return None    
    return _getNearestOperatinghourDefinition(terminalid, refdate)

def isInOperatinghour(ohDefinition:OperatingHourDayDefinition, timestamp:datetime):
    ohDefinitionStart = datetime(timestamp.year, timestamp.month, timestamp.day, ohDefinition.start.hour, ohDefinition.start.minute, ohDefinition.start.second)
    ohDefinitionEnd = datetime(timestamp.year, timestamp.month, timestamp.day, ohDefinition.end.hour, ohDefinition.end.minute, ohDefinition.end.second)
    return ohDefinitionStart <= timestamp and ohDefinitionEnd >= timestamp

def isNearOperatinghourEnd(ohDefinition:OperatingHourDayDefinition, timestamp:datetime):
    return not isInOperatinghour(ohDefinition, timestamp + timedelta(minutes=30))

def _operatinghourCheckEnabled(terminalid:str):
    # feature is enabled if operatinghourscsv is defined in ini file
    return config.terminals[terminalid].operatinghourscsv

def _getNearestOperatinghourDefinition(terminalid:str, refdate:datetime):

    if not terminalid in _operatinghoursCache:
        _operatinghoursCache[terminalid] = _parseOperatinghourscsv(terminalid)

    nearest = None
    for daydef in _operatinghoursCache[terminalid]:
        daydef.applyYear(refdate.year)
        if nearest == None:
            nearest = daydef
        if daydef.start.date()  <= refdate.date():
            daysFromDayDefToRef = abs((refdate.date() - daydef.start.date()).days)
            daysFromNearestToRef = abs((refdate.date() - nearest.start.date()).days)
            if daysFromDayDefToRef <= daysFromNearestToRef:
                nearest = daydef

    return nearest

def _parseOperatinghourscsv(terminalid:str):
    retlst = []
    try:  
        with open(config.terminals[terminalid].operatinghourscsv, newline='') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            for rownum, row in enumerate(csvreader):
                if rownum > 0: # skip headlines
                    csvmonth = int(row[0])
                    csvday = int(row[1])
                    hoursFrom = int(re.search(_operatinghourstimeregex,   row[2])['hours'])
                    minutesFrom = int(re.search(_operatinghourstimeregex, row[2])['minutes'])
                    hoursTo = int(re.search(_operatinghourstimeregex,   row[3])['hours'])
                    minutesTo = int(re.search(_operatinghourstimeregex, row[3])['minutes'])
                    fromLocalTZ = datetime(
                        year=datetime.now().year,
                        month=csvmonth,
                        day=csvday,
                        hour=hoursFrom,
                        minute=minutesFrom, 
                        second=0, 
                        microsecond=0, 
                        tzinfo=timezone.utc).astimezone()
                    toLocalTZ = datetime(
                        year=datetime.now().year,
                        month=csvmonth,
                        day=csvday,
                        hour=hoursTo,
                        minute=minutesTo, 
                        second=59, 
                        microsecond=999, 
                        tzinfo=timezone.utc).astimezone()
                    
                    retlst.append(OperatingHourDayDefinition(
                        start=datetime(
                            year=fromLocalTZ.year,
                            month=fromLocalTZ.month,
                            day=fromLocalTZ.day,
                            hour=fromLocalTZ.hour,
                            minute=fromLocalTZ.minute,
                            second=fromLocalTZ.second,
                            microsecond=fromLocalTZ.microsecond),
                        end=datetime(
                            year=toLocalTZ.year,
                            month=toLocalTZ.month,
                            day=toLocalTZ.day,
                            hour=toLocalTZ.hour,
                            minute=toLocalTZ.minute,
                            second=toLocalTZ.second,
                            microsecond=toLocalTZ.microsecond),
                    ))
    except:
        error = traceback.format_exc()
        log.error(error)
    return retlst
