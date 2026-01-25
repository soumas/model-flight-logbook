
# Model Flight Logbook
<img align="center" src="./_resources/images/github_hero.webp" alt="MFL Terminal Hero image" style="border-radius: 20px;"><br/>

Das ***Model Flight Logbook (MFL)*** ist ein digitales Flugbuch für Modellflugvereine. 
Die Anwendung ist ***einfach, übersichtlich und praxisnah*** konzipiert und unterstützt Pilot:innen sowie Vereine bei der ***Einhaltung der gesetzlichen Anforderungen in Österreich***.

MFL eignet sich insbesondere für den Einsatz als ***Touch-Kiosk-Terminal am Flugplatz*** und bietet zusätzlich eine ***Web-basierte Verwaltungs- und Auswertungsplattform***.

# Features
## Feature-Videos
  [***🎥  MFL Terminal Funktionsübersicht (YouTube)***](https://www.youtube.com/watch?v=kF_Z988H-uU)  
  [***🎥  MFL Admin Funktionsübersicht (YouTube***)](https://www.youtube.com/watch?v=mCskDqg9cJ4)  
## Für Pilot:innen / Mitglieder
- ***Übersichtliches, touch-optimiertes Kiosk-Terminal***  
  Intuitive Bedienung – geeignet für Jung und Alt
- ***Digitales Flugbuch per Check-In / Check-Out***  
  Protokollierung der Anwesenheit und gesetzlich erforderlicher Informationen
- ***Flexible Benutzer-Identifizierung***  
  Anmeldung per RFID-Chip oder über sonstige Eingabegeräte (z. B. Tastatur, Ziffernblock, …)
- ***Dokumenten-Überwachung***  
  Warnungen am Terminal vor Ablauf des Drohnenführerscheins oder der Registrierung
- ***Automatisches Flugverbot***  
  Bei fehlenden oder abgelaufenen Pflichtdokumenten
- ***Individuelle und globale Hinweise***  
  Infos, Warnungen oder Flugverbotsmeldungen – global oder personenbezogen  
- ***Tagesaktuelle Betriebszeiten***  
  Berücksichtigung der erlaubten Flugzeiten (CMT bis CET)  
- ***Export des persönlichen Flugbuchs***  
  Versand per E-Mail über das MFL Terminal  

## Für Vereinsvorstände
- ***Web-basiertes Verwaltungsportal (MFL-Admin)***  
  Zentrale Administration aller Piloten- und Flugdaten
- ***CSV-Export des Flugbuchs***  
  Mit einem Klick, z. B. für behördliche Einreichungen
- ***Verwaltung von Infos, Warnungen und Flugverboten***  
  Global oder pilotenspezifisch definierbar
- ***Aussagekräftige Jahresstatistiken***  
  Übersicht über Auslastung, Flugzeiten und Aktivitäten
- ***E-Mail-Benachrichtigungen an den Administrator***  
  Z.B. Bei Einträgen unter „Besondere Ereignisse“
- ***Automatische Beendigung vergessener Check-Outs***  
  Inklusive Benachrichtigung an die betroffene Pilot:in
- ***Kostengünstig***  
  MFL ist kostenlos und kann auf günstiger Hardware betrieben werden

## Für Systemadministrator:innen
- ***Installations-Script für ein vollständiges Setup***  
  Schnelle und einfache Inbetriebnahme
- ***Update-Script für einfache Aktualisierungen***  
  Per Cronjob automatisierbar
- ***REST-API***  
  Für die Anbindung an Fremdsysteme
- ***Unterstützung von komplexen Setups, wie:***  
  - Mehrere MFL Terminals auf einem Flugplatz  
  - Mehrere Flugplätze pro Verein (z.B. Tal- und Hangflugplatz)  
  - Ein Terminal unterstützt mehrere Server (z.B. bei Flugplatz-Sharing)

  
# Anforderungen
Aufgrund der gewählten Systemarchitektur und der eingesetzten Technologien kann das MFL-System in unterschiedlichsten Konfigurationen betrieben werden – beispielsweise vollständig lokal auf einem einzelnen PC, mit einem Server im Internet oder auf verschiedenen Betriebssystemen wie Windows, Linux, Android oder iOS.

Um die Dokumentation übersichtlich und die Komplexität möglichst gering zu halten, wird im Folgenden ausschließlich ein einziges Setup beschrieben, welches für die Mehrzahl der Modellflugvereine geeignet sein sollte. Fragen zu alternativen Setups oder abweichenden Betriebsformen können gerne über GitHub gestellt werden. Bitte dazu einen Issue mit dem Label "help wanted" eröffnen.

## Rahmenbedingungen
### Installation, Wartung und Betrieb
Die Installation und der Betrieb von MFL sind grundsätzlich einfach. Trotzdem ist ein gewisses Maß an IT Verständnis nötig, um das System mit gutem Gewissen warten und einsetzen zu können. Es ist also Grundvoraussetzung, dass es jemanden im Verein gibt der sich um das System kümmert. Diese Person muss kein Experte sein, aber einen Raspberry Pi aufzusetzen und in ein Netzwerk zu hängen sollte sie beherrschen. Auch Schlagwörter wie Linux, SSH, Bash und crontab sollten ihr nicht gänzlich unbekannt sein.

### Infrastruktur
MFL sollte nach Möglichkeit Zugriff zum Internet haben. Eine rechtskonforme Flugbuchführung ist zwar auch ohne möglich, allerdings gibt es gravierende Einschränkungen. Neben der Notwendigkeit eines zusätzlichen RTC-Modules (damit der Raspberry Pi die Zeit nicht vergisst), aufwändiger Wartung (Updates) und fehlenden E-Mail Benachrichtigungen ist die ***Datensicherung*** das Hauptproblem.

## Hardware
Für den Aufbau des MFL Systems sind folgende Hardware-Komponenten erforderlich.
* ***Raspberry Pi 4 model B***  
Grundsätzlich kann jedes Raspberry Pi Modell verwendet werden, welches das Betriebssystem "Raspberry Pi OS 64-bit" unterstützt und mit dem Touch Display kompatibel ist.  
https://www.raspberrypi.com/products/raspberry-pi-4-model-b/
* ***microSD Karte***  
Auch wenn MFL nur wenig Speicherbedarf hat, empfiehlt es sich eine microSD mit mindestens 32 GB Speicher einzusetzen. Außerdem sollte auf eine gute Qualität und Temperaturbeständigkeit geachtet werden, um MFL auch in unklimatisierter Umgebung möglichst lange ohne Aufall betreiben zu können.
* ***Raspberry Pi 7″ Touch Display (800 x 480 Pixel)***  
Das originale Touch Display (Version 1) harmoniert perfekt mit dem Raspberry Pi 4 model B und hat mit 800 x 480 Pixel eine optimale Auflösung. Kein Setup und problemloser Betrieb.  
https://www.raspberrypi.com/products/raspberry-pi-touch-display/
* ***USB RFID-Scanner***  
Der RFID Scanner wird per USB an den Raspberry Pi angeschlossen  
https://www.neuftech.net/products/40
* ***MFL Terminal Gehäuse***  
Die 3D-Druckdateien für das originale MFL Terminal Gehäuse stehen auf thingiverse.com zur Verfügung. Der Druck ist nicht sonderlich schwierig und wird unter Befolgung der Hinweise bestimmt problemlos klappen. Wer keinen passenden 3D-Drucker hat aber trotzdem das originale Gehäuse haben möchte, möge sich gerne an office@soumasoft.com wenden. 
https://www.thingiverse.com/thing:7279187  
Alternativ kann natürlich jedes andere Gehäuse verwendet werden, in dem das Display und der Raspberry Pi Platz finden.   
* ***Diverse Kleinteile***  
 Für die Befestigung des Terminals, den Einbau in das Gehäuse und die Verkabelung sind diverse Kleinteile nötig, die aber teilweise vom Setup abhängig sind und hier wohl nicht vollständig aufgelistet werden können.  

# Installation
## Raspberry Pi vorbereiten
1. ***Touch Display an Raspberry Pi anschließen***  
[🎥  Videoanleitung - Raspberry Pi Touch Display anschließen (YouTube)](https://youtu.be/rG4MDcAez1c)  
[📖 Originale Dokumentation (raspberrypi.com)](https://www.raspberrypi.com/documentation/accessories/display.html)
2. ***"Raspberry Pi OS (64-bit)" installieren***   
https://www.raspberrypi.com/software/

## MFL Installation  
Per SSH oder VNC auf den Raspberry Pi verbinden und folgende Befehle in der Bash ausführen:

```bash
# system aktualisieren
sudo apt update && sudo apt upgrade -y

# Im Home-Verzeichnis den Unterordner "mfl" erstellen und hinein springen
mkdir ~/mfl && cd ~/mfl

# mfl installationsscript herunterladen und ausführbar machen
wget https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/install.sh && chmod +x install.sh

# mfl-server (Port 80) und mfl-terminal installieren
# TODO !!!!! während der Installation ist die Server-Konfiguration vorzunehmen 
./install.sh 80



# nach erfolgreicher Installation kann das Installationsscript wieder gelöscht werden
rm install.sh

```

# Betrieb

## Updates


## Backup
Die MFL Flugbuch-Daten werden gesammelt in einer SQLite-Datenbank gespeichert. SQLite ist ein sehr populäres Datenbanksystem, welches alle Informationen in einer einzigen Datei speichert. Ein Backup kann also denkbar einfach durchgeführt werden, indem man diese eine Datei auf einem externen Speicher sichert. Ein weiterer Vorteil dieser Architektur ist es, dass man die Datenbank-Datei mit jedem SQLite-fähigen Datenbankbrowser öffnen kann. So kann notfalls auch ohne MFL darauf zugegriffen werden.

***⚡⚡⚡ Achtung ⚡⚡⚡*** Ein tägliches Backup der Flugbuch-Daten ist ein absolutes must have! Die Austro Control kann Auszüge davon bekanntlich anfordern und dann müssen die Daten verfügbar sein! Meine langjährige Erfahrung zeigt, dass die SD Karten in einem Raspberry Pi früher oder später kaputt werden - insbesondere wenn das Gerät in einem unklimatisierten Umfeld betrieben wird, wie bei Vereinshütten/Ladehütten häufig der Fall ist. Mit einem tagesaktuellen Datenbank-Backup und ggf. sogar einem Backup der MFL Serverkonfiguration ist das kein Problem und die Wiederherstellung eine Arbeit von maximal einer Stunde.


# Themen (TMP)
* Datenschutz & DSGVO
* Backup!!


# Disclaimer
Der Haftungsausschluss ist grundsätzlich bereits über die verwendete Lizenz geregelt. Trotzdem weise ich an dieser Stelle noch einmal explizit darauf hin, dass es sich hier um ein privates Projekt handelt. Keines der Funktionalitäten wurde mit öffentlichen Stellen abgestimmt. Der Einsatz des Systems erfolgt auf vollständiges Risiko des Betreibers.

