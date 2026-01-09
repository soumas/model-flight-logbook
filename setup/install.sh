#!/bin/bash

userinput=""

wget https://github.com/soumas/model-flight-logbook/releases/latest/download/version  && versionnumber=$(cat ./version) && rm ./version
echo "latest MFL version: $versionnumber"

echo "install server? (y/n)"
read userinput
if [ $userinput = "y" ]; then
    mkdir mfl-server
    cd mfl-server
    wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip
    python -m venv venv & source venv/bin/activate
    python -m pip install -r requirements.txt
    if [ ! -f "./server-config.ini" ]; then
        mv ./server-config-template.ini ./server-config.ini
        userinput="y"
        nano ./server-config.ini
    else
        echo "server-config.ini already exists, do you want to edit it? (y/n)"
        read userinput
    fi
    if [ $userinput = "y" ]; then
        nano ./server-config.ini
    fi
    uvicorn main:app --port 8082 --host "0.0.0.0" --log-config log-config.ini &
    cd ..
fi
echo "install terminal? (y/n)"
read userinput
if [ $userinput = "y" ]; then
    mkdir mfl-terminal
    cd mfl-terminal
    #wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-x64.zip && unzip -o mfl-terminal-linux-x64.zip && rm mfl-terminal-linux-x64.zip
    chmod +x ./mfl_terminal
    ./mfl_terminal &
    cd ..
fi