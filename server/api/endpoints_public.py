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
        pilotidinstruction=config.terminals[cfg].pilotidinstruction,
    ) for cfg in config.terminals]
