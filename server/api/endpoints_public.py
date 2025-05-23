from api.dtos import TerminalConfigDTO
from config.configmanager import config
from api.apimanager import api

@api.get("/public/terminalconfiglist", response_model=list[TerminalConfigDTO])
def get_terminal_config_list():
    return [TerminalConfigDTO(
        terminalid=cfg,
        terminaltype=config.terminals[cfg].terminaltype,
        airportname=config.terminals[cfg].airportname,
        terminalname=config.terminals[cfg].terminalname,
        maxAltitudeM=config.terminals[cfg].max_altitude_m,
        maxAltitudeWithoutObserverM=config.terminals[cfg].max_altitude_without_observer_m,
        maxNumFlights=config.terminals[cfg].max_num_flights
    ) for cfg in config.terminals]
