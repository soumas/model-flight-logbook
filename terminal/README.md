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
switch from Wayland to x11 --> sudo raspi-config --> Advanced Options --> Wayland
edit /etc/lightdm/lightdm.conf --> from "#xserver-command = X" to "xserver-command = X -nocursor"