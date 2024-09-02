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

# for db password
sudo apt install libsqlcipher-dev
pip install pysqlcipher3

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