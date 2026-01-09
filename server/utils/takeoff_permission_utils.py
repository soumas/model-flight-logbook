from datetime import datetime, timedelta
from db.entities import PilotEntity
from utils.operatinghours_utils import findOperatinghourDayDefinition, isInOperatinghour, isNearOperatinghourEnd
from utils.messages_utils import appendMessages
from config.configmanager import config

def validateTakeoffPermission(terminalid:str, pilot:PilotEntity, allowNonePilot = False):
    
    vr = TakeoffPermissionValidationResult()
    
    # operating hours
    now = datetime.now()
    operatingHourDayDefinition = findOperatinghourDayDefinition(terminalid, now)
    if operatingHourDayDefinition != None:
        if not isInOperatinghour(operatingHourDayDefinition, now):
            vr._errorMessagesPilot.append('Außerhalb der Betriebszeit ist kein Flugbetrieb erlaubt.')
        elif isNearOperatinghourEnd(operatingHourDayDefinition, now):
            vr._warnMessagesPilot.append('Betriebszeit endet um ' + operatingHourDayDefinition.end.strftime('%H:%M') + ' Uhr')

    # pilot dependent validations
    if pilot != None:

        # active
        if(pilot.active != True):
            vr._errorMessagesPilot.append('Konto inaktiv')

        # pilot specific messages
        appendMessages(vr._infoMessagesPilot, pilot.infoMessages)
        appendMessages(vr._warnMessagesPilot, pilot.warnMessages)
        appendMessages(vr._errorMessagesPilot, pilot.errorMessages)
        # global messages
        appendMessages(vr._infoMessagesPilot, config.terminals[terminalid].pilot_info_messages)
        appendMessages(vr._warnMessagesPilot, config.terminals[terminalid].pilot_warn_messages)
        appendMessages(vr._errorMessagesPilot, config.terminals[terminalid].pilot_error_messages)

        # pilot license
        if(pilot.validateAcPilotlicense):
            if(pilot.acPilotlicenseValidTo == None):
                vr._errorMessagesPilot.append('Drohnenführerschein fehlt')
            elif(pilot.acPilotlicenseValidTo < datetime.now().date()):
                vr._errorMessagesPilot.append('Drohnenführerschein abgelaufen')
            elif(pilot.acPilotlicenseValidTo < datetime.now().date() + timedelta(days=30)):
                vr._warnMessagesPilot.append('Dein Drohnenführerschein läuft am ' + pilot.acPilotlicenseValidTo.strftime('%d.%m.%Y') + ' ab! Denke daran, ihn rechtzeitig zu verlängern.')

        # registration
        if(pilot.validateAcRegistration):
            if(pilot.acRegistrationValidTo == None):
                vr._errorMessagesPilot.append('Registrierung fehlt')
            elif(pilot.acRegistrationValidTo < datetime.now().date()):
                vr._errorMessagesPilot.append('Registrierung abgelaufen')
            elif(pilot.acRegistrationValidTo < datetime.now().date() + timedelta(days=30)):
                vr._warnMessagesPilot.append('Deine Registrierung läuft am ' + pilot.acRegistrationValidTo.strftime('%d.%m.%Y') + ' ab! Denke daran, sie rechtzeitig zu verlängern.')

    elif allowNonePilot != True:
        raise Exception('validation without pilot not allowed!')

    return vr

class TakeoffPermissionValidationResult:
    def __init__(self):
        self._infoMessagesPilot = []
        self._warnMessagesPilot = []
        self._errorMessagesPilot = []

    def getInfoMessagesPilot(self):
        return self._infoMessagesPilot
    
    def getWarnMessagesPilot(self):
        return self._warnMessagesPilot
    
    def getErrorMessagesPilot(self):
        return self._errorMessagesPilot
       
    def isTakeoffPermitted(self):
        # python returns false if errorMessages is emtpy - OMG!
        return not self.getErrorMessagesPilot()
    
    