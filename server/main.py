from config.manager import *
from db.entities import *
from api.manager import *
from api.endpoints_admin import *
from api.endpoints_terminal import *

if __name__ == "__main__":
	import uvicorn
	uvicorn.run(api, host=config['api']['hostname'], port=int(config['api']['port']))
