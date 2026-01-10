#!/bin/bash

origdir=$(pwd)
param1=$1

if [[ "$param1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    target_version="$param1"
else
    wget -q https://github.com/soumas/model-flight-logbook/releases/latest/download/version
    target_version=$(cat version)
    rm version
fi

if [ -z "$target_version" ]; then
    echo "Could not determine latest MFL version. Exiting."
    exit 1
fi

echo "Target version: $target_version"

for dir in mfl*/; do

    cd "$origdir"
    if [ ! -d "$dir" ]; then
        continue
    fi

    echo "Processing $dir"
    cd "$dir"

    installed_version=$(cat version)
    if [ "$installed_version" = "$target_version" ]; then        
        if [ ! "$param1" = "force" ]; then
            echo "Installed version is equal to target version. Skipping..."
            continue
        else 
            echo "Installed version is equal to target version but force flag is set, updating..."
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
        wget https://github.com/soumas/model-flight-logbook/releases/download/mfl-$target_version/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

        # restart terminal
        ./run-terminal.sh &

    elif [[ "$dir" == mfl-server-*"/" ]]; then
        
        ########## SERVER UPDATE ##########

        # download, unzip and cleanup latest server release
        wget https://github.com/soumas/model-flight-logbook/releases/download/mfl-$target_version/mfl-server.zip && unzip -o mfl-server.zip && rm mfl-server.zip

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

echo "Update process completed."