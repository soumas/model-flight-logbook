#!/bin/bash

serverport=${1:-8082} # use first argument as port, default to 8082
installdir="mfl-server-$serverport"
servicename="mfl-server-$serverport.service"

if [ ! -d "$installdir" ]; then
    mkdir "$installdir"
    cd "$installdir" 
    wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip
    python -m venv venv
    source venv/bin/activate
    python -m pip install -r requirements.txt
    mv ./server-config-template.ini ./server-config.ini
    nano ./server-config.ini
    cp ../mfl-server-template.service ./$servicename
    gn=$(id -gn)
    sed -i "s|PORT|$serverport|g" ./$servicename
    sed -i "s|ROOTPATH|${PWD//\//\\/}|g" ./$servicename
    sed -i "s|USER|${USER}|g" ./$servicename
    sed -i "s|GROUP|$gn|g" ./$servicename
    sudo mv ./$servicename /etc/systemd/system/$servicename
    sudo systemctl daemon-reload
    sudo systemctl enable $servicename
    sudo systemctl start $servicename
else
    echo "Directory $installdir already exists. Do you want to uninstall the server? (y/n)"
    read userinput
    if [ "$userinput" = "y" ]; then
        sudo systemctl stop $servicename
        sudo systemctl disable $servicename
        sudo rm /etc/systemd/system/$servicename
        sudo systemctl daemon-reload
        sudo systemctl reset-failed
        sudo rm -rf "$installdir"
    fi
fi