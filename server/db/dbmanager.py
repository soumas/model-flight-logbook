
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from config.configmanager import config
 
# Database setup
engine = create_engine(config.db.url)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency to get the database session
def get_db():
	db = SessionLocal()
	try:
		yield db
	finally:
		db.close()
