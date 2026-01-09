# Model Flight Logbook Server

Server Komponente für Model Flight Logbook

## Installation, Raspberry Pi OS

### Vorbereitung
```shell
# system update (optional)
sudo apt update && sudo apt upgrade;

# python-dev modul installieren (Version "python --version" abrufen und ggf. austauschen)
sudo apt install python3.11-dev

# Das Modul "venv" ist normal vorinstalliert, aber nicht immer. Zur Sicherheit:
sudo apt install python3-venv

# Installationsordner erstellen (beliebiges Verzeichnis, z.B. ~/mfl-server/)
mkdir ~/mfl-server && cd ~/mfl-server

# Venv in diesem Ordner erstellen und aktivieren
python3 -m venv venv && source venv/bin/activate

# mfl-server.zip herunterladen & entpacken
# ACHTUNG: "X.X.X" mit der aktuellsten Versionsnummer ersetzen
wget https://github.com/soumas/model-flight-logbook/releases/download/mfl-X.X.X/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip

# python pakete installieren (kann lange dauern)
python -m pip install -r requirements.txt

# konfigurieren (Optionen siehe https://github.com/soumas/model-flight-logbook/tree/main/server#konfiguration)
mv server-config-template.ini server-config.ini
nano server-config.ini 


```

### Erster Testlauf
```shell
# Server auf port 8082 starten und logs beobachren
uvicorn main:app --port 8082 --host "0.0.0.0" --log-config log-config.ini

# Nach Serverstart Testcall machen --> sendet Test-Email an die Admin-Adresse
curl --header "x-api-key: your_secure_api_key" localhost:8082/admin/test/admin_notification

# Über einen Browser kann die API Dokumentation aufgerufen werden
http://localhost:8082/docs
```

### Server als systemd-Service registrieren
```shell
# Service Unit File erstellen
sudo nano /etc/systemd/system/mfl-server.service

# --------- START Inhalt mfl-server.service ----------
[Unit]
Description=Model Flight Logbook Server

[Service]
Type=simple
WorkingDirectory=/home/pi/mfl-server/
ExecStart=/home/pi/mfl-server/venv/bin/uvicorn main:app --port 8082 --log-config log-config.ini
Restart=always
User=pi
Group=pi

[Install]
WantedBy=multi-user.target
# --------- ENDE Inhalt mfl-server.service ----------

sudo systemctl enable mfl-server.service
sudo systemctl start mfl-server.service
sudo systemctl status mfl-server.service

```

### Server update
```shell
cd ~/mfl-server/
# ACHTUNG: "X.X.X" mit der aktuellsten Versionsnummer ersetzen
wget https://github.com/soumas/model-flight-logbook/releases/download/mfl-X.X.X/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip && sudo systemctl restart mfl-server.service

```



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
