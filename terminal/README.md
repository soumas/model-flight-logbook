# mfl_terminal

User Interface to interact with mfl server

TODO: setup instructions (https://github.com/Snapp-X/snapp_installer/)

Kiosk-Mode nicht im Einsatz, hat vermutlich nicht funktioniert
nano .config/autostart/mfl-terminal.desktop -->
[Desktop Entry]
Name=Mfl-Terminal
Type=Application
Exec=/home/pi/mfl/model-flight-logbook/terminal/build/linux/arm64/release/bundle/mfl_terminal
Terminal=false

---------
dirty way to disable mouse cursor for touch device (rename pointer images):

``` bash
for file in /usr/share/icons/PiXflat/cursors/*; do sudo mv "$file" "${file}.bak"; done 
```

reverse

``` bash
for file in /usr/share/icons/PiXflat/cursors/*.bak; do sudo mv "$file" "${file/.bak/}"; done 
```

---------------

activate raspberry pi screen blanking:

* make sure that you use wayland (raspi-config --> Advanced -->Wayland)
* enable screen blanking (raspi-config --> Display Options --> Screen Blanking)
* activate screen blanking for fullscreen applications (disable by default)
    * nano ~/.config/wayfire.ini
    * in block [idle] add row "disable_on_fullscreen=false"
    * you may also adjust the dpms_timeout in this file (=seconds the sreen remains active before screen blanking gets executed)
    