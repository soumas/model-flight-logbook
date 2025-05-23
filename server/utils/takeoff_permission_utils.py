from datetime import datetime, timedelta
from db.entities import PilotEntity
from utils.operatinghours_utils import findOperatinghourDayDefinition, isInOperatinghour, isNearOperatinghourEnd
from utils.utm import check_utm_prmitted
from utils.messages_utils import appendMessages
from config.configmanager import config

def validateTakeoffPermission(terminalid:str, pilot:PilotEntity, allowNonePilot = False):
    
    vr = TakeoffPermissionValidationResult()
    
    # configured global validations
    appendMessages(vr._infoMessagesGlobal, config.terminals[terminalid].infoMessages)
    appendMessages(vr._warnMessagesGlobal, config.terminals[terminalid].warnMessages)
    appendMessages(vr._errorMessagesGlobal, config.terminals[terminalid].errorMessages)

    # operating hours
    now = datetime.now()
    operatingHourDayDefinition = findOperatinghourDayDefinition(terminalid, now)
    if operatingHourDayDefinition != None:
        if not isInOperatinghour(operatingHourDayDefinition, now):
            vr._errorMessagesGlobal.append('Außerhalb der Betriebszeit ist kein Flugbetrieb erlaubt.')
        elif isNearOperatinghourEnd(operatingHourDayDefinition, now):
            vr._warnMessagesGlobal.append('Betriebszeit endet um ' + operatingHourDayDefinition.end.strftime('%H:%M') + ' Uhr')

    # pilot dependent validations
    if pilot != None:

        # active
        if(pilot.active != True):
            vr._errorMessagesPilot.append('Konto inaktiv')

        # pilot specific messages
        appendMessages(vr._infoMessagesPilot, pilot.infoMessages)
        appendMessages(vr._warnMessagesPilot, pilot.warnMessages)
        appendMessages(vr._errorMessagesPilot, pilot.errorMessages)                  

        # pilot license
        if(pilot.validateAcPilotlicense):
            if(pilot.acPilotlicenseValidTo == None):
                vr._errorMessagesPilot.append('Drohnenführerschein fehlt')
            elif(pilot.acPilotlicenseValidTo < datetime.now().date()):
                vr._errorMessagesPilot.append('Drohnenführerschein abgelaufen')
            elif(pilot.acPilotlicenseValidTo < datetime.now().date() + timedelta(days=30)):
                vr._warnMessagesPilot.append('Dein Drohnenführerschein läuft am ' + pilot.acPilotlicenseValidTo.strftime('%d.%m.%Y') + ' ab!')

        # registration
        if(pilot.validateAcRegistration):
            if(pilot.acRegistrationValidTo == None):
                vr._errorMessagesPilot.append('Registrierung fehlt')
            elif(pilot.acRegistrationValidTo < datetime.now().date()):
                vr._errorMessagesPilot.append('Registrierung abgelaufen')
            elif(pilot.acRegistrationValidTo < datetime.now().date() + timedelta(days=30)):
                vr._warnMessagesPilot.append('Deine Registrierung läuft am ' + pilot.acRegistrationValidTo.strftime('%d.%m.%Y') + ' ab!')

        # utm
        if config.utm.enabled:
            if(check_utm_prmitted(pilot)):
                vr._utmPermittedPilot = True
            else:
                vr._utmPermittedPilot = False
                vr._infoMessagesPilot.append('Keine Flugfreigabeanforderung (UTM) über dieses Konto')

    elif allowNonePilot != True:
        raise Exception('validation without pilot not allowed!')

    return vr

class TakeoffPermissionValidationResult:
    def __init__(self):
        self._infoMessagesGlobal = []
        self._warnMessagesGlobal = []
        self._errorMessagesGlobal = []
        self._infoMessagesPilot = []
        self._warnMessagesPilot = []
        self._errorMessagesPilot = []
        self._utmPermittedPilot = False

    def getInfoMessagesGlobal(self):
        return self._infoMessagesGlobal
    
    def getWarnMessagesGlobal(self):
        return self._warnMessagesGlobal
    
    def getErrorMessagesGlobal(self):
        return self._errorMessagesGlobal
 
    def getInfoMessagesPilot(self):
        return self._infoMessagesPilot
    
    def getWarnMessagesPilot(self):
        return self._warnMessagesPilot
    
    def getErrorMessagesPilot(self):
        return self._errorMessagesPilot + self._errorMessagesGlobal
       
    def isTakeoffPermitted(self):
        # python returns false if errorMessages is emtpy - OMG!
        return not self.getErrorMessagesGlobal() and not self.getErrorMessagesPilot()
    
    def isUtmPermitted(self):
        return self._utmPermittedPilot and not self._errorMessagesGlobal
    