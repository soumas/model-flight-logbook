#!/bin/bash

serverport=${1:-8082} # use first argument as port, default to 8082
installdir="mfl-server-$serverport"
servicename="mfl-server-$serverport.service"

if [ -d "$installdir" ]; then
    sudo systemctl stop $servicename
    sudo systemctl disable $servicename
    sudo rm /etc/systemd/system/$servicename
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
    sudo rm -rf "$installdir"
else
    echo "Directory $installdir not found."
fi
