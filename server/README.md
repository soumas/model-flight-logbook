# Model Flight Logbook Server

Server Component for the Model Flight Logbook

## Configuration

TODO

## Install dependencies

```shell
// pyhton
sudo apt install python3-pip

// fastapi
pip install fastapi --> TODO: Fix versions
pip install fastapi-mail
pip install pydantic
pip install uvicorn
pip install sqlalchemy
pip install alembic
pip install requests

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
