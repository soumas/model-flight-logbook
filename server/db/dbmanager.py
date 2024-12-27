
import os
from alembic.config import Config
from alembic import command
from sqlalchemy import StaticPool, create_engine
from sqlalchemy.orm import sessionmaker

from config.configmanager import config
from utils.logger import log
 
# Database setup
engine = create_engine(config.logbook.dburl, echo=config.logbook.debug, poolclass=StaticPool)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency to get the database session
def get_db():
	db = SessionLocal()
	try:
		yield db
	except:
		db.rollback()		
	finally:
		db.close()

def execute_db_migration():
	log.info('execute_db_migration')
	alembic_cfg = Config()
	alembic_cfg.set_main_option('script_location', './db/migration/')
	alembic_cfg.set_main_option('sqlalchemy.url', config.logbook.dburl)
	command.upgrade(alembic_cfg, 'head')
