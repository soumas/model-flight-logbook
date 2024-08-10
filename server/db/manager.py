
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from config.manager import config
 
# Database setup
engine = create_engine(config['sqlalchemy']['url'])
sessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency to get the database session
def get_db():
	db = sessionLocal()
	try:
		yield db
	finally:
		db.close()
