#!/bin/bash

serverport=$1

wget -q https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/install-server.sh
sudo chmod +x ./install-server.sh
./install-server.sh $serverport
rm ./install-server.sh

wget -q https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/install-terminal.sh
sudo chmod +x ./install-terminal.sh
./install-terminal.sh $serverport
rm ./install-terminal.sh
