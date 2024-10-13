# Model Flight Logbook Server

Server Komponente für Model Flight Logbook

## Installation, Raspberry
* DB TBD
* Python TBD

## Configuration
Bevor der Server betrieben werden kann, sind einige Konfigurationen nötig. Alle Einstellungen sind in der Datei '**/config/server-config.ini**' zu definieren. **ACHTUNG**! Ändern Sie die Datei 'server-config *-defaults*.ini' nicht, da diese bei jedem Update überschrieben wird. Erstellen Sie stattdessen die genannte Datei (ohne '-defaults') um die Standardwerte mit Ihren Parametern zu überschreiben.

### Sektion 'logbook'
| Schlüssel | Pflicht | Standardwert | Beschreibung |
| --- | --- | --- | --- |
| dburl | * | | Connectionstring für den Verbindungsaufbau zur Datenbank.<br/>https://docs.sqlalchemy.org/en/20/core/engines.html#backend-specific-urls |
| apikey_admin | * | | Api-Key (Passwort) für administrative Endpunkte |
| admin_email | * | | Empfänger E-Mail Adresse des Systemadministrators |
| forward_comment | | True | Bleibt das Bemerkungsfeld beim Beenden eines Flugtages nicht leer, so wird eine Nachricht an den Systemadministrator versendet ('False' um Feature zu deaktivieren)
| debug | | False | Erweitertes Logging für Analyse und Fehlersuche |


### Sektion 'smtp'
TBD

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
