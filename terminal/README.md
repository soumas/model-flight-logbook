# model_flight_logbook

User Interface to interact with mfl server

TODO: setup instructions (https://github.com/Snapp-X/snapp_installer/)

Kiosk-Mode nicht im Einsatz, hat vermutlich nicht funktioniert
nano .config/autostart/mfl-terminal.desktop -->
[Desktop Entry]
Name=Mfl-Terminal
Type=Application
Exec=/home/pi/mfl/model-flight-logbook/terminal/build/linux/arm64/release/bundle/model_flight_logbook
Terminal=false

---------
disable mouse cursor for touch device:
dirty, but works: 
- rename cursor images: 
    sudo mv /usr/share/icons/PiXflat/cursors/left_ptr /usr/share/icons/PiXflat/cursors/left_ptr.bak
    sudo mv /usr/share/icons/PiXflat/cursors/hand /usr/share/icons/PiXflat/cursors/hand.bak
    sudo mv /usr/share/icons/PiXflat/cursors/text /usr/share/icons/PiXflat/cursors/text.bak
- rename it back to reactivet cursors
