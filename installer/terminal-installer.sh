#!/bin/bash

installdir="mfl-terminal"
autostartfilename="mfl-terminal.desktop"
autostartfilepath="$HOME/.config/autostart/$autostartfilename"

if [ ! -d "$installdir" ]; then
    mkdir "$installdir"
    cd "$installdir"

    if [[ "$(uname -m)" == "x86_64" ]]; then
        arch="x64"
    elif [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then
        arch="arm64"
    else
        echo "System architecture $(uname -m) is not supported."
        exit 0
    fi

    wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

    startcommand="$PWD/mfl_terminal --full-screen"
    cp ../mfl-terminal-template.desktop ./$autostartfilename
    sed -i "s|COMMAND|$startcommand|g" ./$autostartfilename
    mv ./$autostartfilename $autostartfilepath
else
    echo "Directory $installdir already exists."
fi
