#!/bin/bash

serverport=${1:-8082} # use first argument as port, default to 8082
installdir="mfl-server-$serverport"
tmpfilesdir="installertmpfiles"
servicename="mfl-server-$serverport.service"

if [ ! -d "$installdir" ]; then

    # create target directory
    mkdir "$installdir"
    cd "$installdir" 

    # download, unzip and cleanup latest server release
    wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip
    
    # init python venv and install requirements
    python -m venv venv
    source venv/bin/activate
    python -m pip install -r requirements.txt

    # setup server config
    mv ./server-config-template.ini ./server-config.ini
    nano ./server-config.ini

    # create run-server script
    wget -P $tmpfilesdir https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/files/run-server.sh.tmpl
    cp "./$tmpfilesdir/run-server.sh.tmpl" ./run-server.sh
    sed -i "s|PORT|$serverport|g" ./run-server.sh

    # preapre systemd service files
    wget -P $tmpfilesdir https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/files/mfl-server.service.tmpl    
    cp "./$tmpfilesdir/mfl-server.service.tmpl" ./$servicename
    sed -i "s|PORT|$serverport|g" ./$servicename
    sed -i "s|ROOTPATH|${PWD//\//\\/}|g" ./$servicename
    sed -i "s|USER|${USER}|g" ./$servicename
    gn=$(id -gn)
    sed -i "s|GROUP|$gn|g" ./$servicename

    # install systemd service
    sudo mv ./$servicename /etc/systemd/system/$servicename
    sudo systemctl daemon-reload
    sudo systemctl enable $servicename
    sudo systemctl start $servicename

    # cleanup
    rm -rf $tmpfilesdir
else
    echo "Directory $installdir already exists. Do you want to uninstall the server? (y/n)"
    read userinput
    if [ "$userinput" = "y" ]; then

        # uninstall systemd service
        sudo systemctl stop $servicename
        sudo systemctl disable $servicename
        sudo rm /etc/systemd/system/$servicename
        sudo systemctl daemon-reload
        sudo systemctl reset-failed

        # remove installation directory
        sudo rm -rf "$installdir"
    fi
fi