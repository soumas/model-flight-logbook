# Simple Time Punch Server

Simple Time Punch Server (Python FastAPI & SQLite Database)

## Install dependencies

```shell
// pyhton
sudo apt install python3-pip

// fastapi
pip install fastapi
pip install pydantic
pip install sqlalchemy
pip install uvicorn
pip install fastapi-mail

```

## Selenium (utm login)
```shell
pip install selenium
```

Unzip latest version of geckodriver for your platform to /usr/local/bin: https://github.com/mozilla/geckodriver/releases


## Run

```shell
uvicorn main:app --port 8065 --log-config ./logconfig-prod.ini
```