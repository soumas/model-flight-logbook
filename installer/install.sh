#!/bin/bash

serverport=$1

rmfile=false
if [ ! -f "install-server.sh" ]; then
    wget -q https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/install-server.sh
    rmfile=true
fi
sudo chmod +x ./install-server.sh
./install-server.sh $serverport
if [ "$rmfile" = true ]; then
    rm ./install-server.sh
fi

rmfile=false
if [ ! -f "install-terminal.sh" ]; then
    wget -q https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/install-terminal.sh
    rmfile=true
fi
sudo chmod +x ./install-terminal.sh
./install-terminal.sh $serverport
if [ "$rmfile" = true ]; then
    rm ./install-terminal.sh
fi
