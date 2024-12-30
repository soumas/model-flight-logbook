from utils.logger import log
from utils.scheduler import scheduler

#@scheduler.scheduled_job('interval', seconds=1)
async def fetch_current_time():
    log.debug("xxxxxxxxxxxxxxxxxxx")