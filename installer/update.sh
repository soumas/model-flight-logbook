#!/bin/bash

for dir in mfl*/; do
    echo "Processing $dir"
    cd "$dir"
    if [ "$dir" = "mfl-terminal/" ]; then

        # if [[ "$(uname -m)" == "x86_64" ]]; then
        #     arch="x64"
        # elif [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then
        #     arch="arm64"
        # else
        #     echo "System architecture $(uname -m) is not supported."
        #     exit 0
        # fi

        # pkill model_flight_lo
        # wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

        # export DISPLAY=":0"
        startcommand="$PWD/mfl_terminal --full-screen"
        "$startcommand &"
    else
        echo "This is a server directory."
    fi
    cd ..
done