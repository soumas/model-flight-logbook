#!/bin/bash

for dir in mfl*/; do
    echo "Processing $dir"
    cd "$dir"
    if [ "$dir" = "mfl-terminal/" ]; then
        ########## TERMINAL UPDATE ##########
        # determine system architecture
        if [[ "$(uname -m)" == "x86_64" ]]; then
            arch="x64"
        elif [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then
            arch="arm64"
        else
            echo "System architecture $(uname -m) is not supported."
            exit 0
        fi

        # stop running terminal
        pkill mfl_terminal

        # download, unzip and cleanup latest terminal release
        wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

        # restart terminal
        nohup ./run-terminal.sh &
    else
        ########## SERVER UPDATE ##########        

        # download, unzip and cleanup latest server release
        wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip

        # stop running server
        # TODO: Dynamically determine service name instead of hardcoding port 8082
        sudo systemctl stop mfl-server-8082.service

        # init python venv and install requirements
        python -m venv venv
        source venv/bin/activate
        python -m pip install -r requirements.txt

        # restart server
        # TODO: Dynamically determine service name instead of hardcoding port 8082
        sudo systemctl start mfl-server-8082.service
    fi
    cd ..
done