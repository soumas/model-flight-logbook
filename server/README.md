# Simple Time Punch Server

Simple Time Punch Server (Python FastAPI & SQLite Database)

## Install dependencies

```shell
// pyhton
sudo apt install python3-pip

// fastapi
pip install fastapi
pip install fastapi-mail
pip install pydantic
pip install uvicorn
pip install sqlalchemy
pip install alembic

```

## Selenium (utm login)
```shell
pip install selenium
```

Unzip latest version of geckodriver for your platform to /usr/local/bin: https://github.com/mozilla/geckodriver/releases

## DB Migration
```shell
-- install update
cd /db/migration
alembic upgrade head

-- create new migration script blueprint
alembic revision -m "description of script action"
```

## Run

```shell
uvicorn main:app --port 8065 --log-config ./logconfig-prod.ini
```