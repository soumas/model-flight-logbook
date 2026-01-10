#!/bin/bash

origdir=$(pwd)
forceupdate=$1

wget -q https://github.com/soumas/model-flight-logbook/releases/latest/download/version
latest_version=$(cat version)
rm version

if [ -z "$latest_version" ]; then
    echo "Could not determine latest MFL version. Exiting."
    exit 1
fi

echo "Latest MFL version is $latest_version"

for dir in mfl*/; do
    echo "Processing $dir"
    cd "$origdir"
    cd "$dir"

    installed_version=$(cat version)
    if [ "$installed_version" = "$latest_version" ]; then        
        if [ ! "$forceupdate" = "force" ]; then
            echo "Already up to date. Skipping..."
            continue
        else 
            echo "Already up to date but force flag is set, updating..."
        fi
    fi    

    if [ "$dir" = "mfl-terminal/" ]; then        

        ########## TERMINAL UPDATE ##########
        
        # determine system architecture
        arch=$(uname -m)
        if [[ "$arch" == "x86_64" ]]; then
            arch="x64"
        elif [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
            arch="arm64"
        else
            echo "System architecture $(uname -m) is not supported."
            exit 1
        fi

        # stop running terminal
        pkill mfl_terminal

        # download, unzip and cleanup latest terminal release
        wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

        # restart terminal
        ./run-terminal.sh &
    else
        
        ########## SERVER UPDATE ##########

        # download, unzip and cleanup latest server release
        wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip

        # determine server port from directory name
        port=$(echo "$dir" | grep -o 'mfl-server-[0-9]\+' | grep -o '[0-9]\+')

        # stop server
        sudo systemctl stop "mfl-server-$port.service"

        # init python venv and install requirements
        python -m venv venv
        source venv/bin/activate
        python -m pip install -r requirements.txt

        # restart server
        sudo systemctl start "mfl-server-$port.service"

    fi
done