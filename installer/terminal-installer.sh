#!/bin/bash

installdir="mfl-terminal"
tmpfilesdir="installertmp"
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
    wget -P $tmpfilesdir https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/mfl-terminal-template.desktop

    startcommand="$PWD/mfl_terminal --full-screen"
    cp "./$tmpfilesdir/mfl-terminal-template.desktop" ./$autostartfilename
    sed -i "s|COMMAND|$startcommand|g" ./$autostartfilename
    mv ./$autostartfilename $autostartfilepath

    rm -rf $tmpfilesdir
else
    echo "Directory $installdir already exists. Do you want to uninstall the terminal? (y/n)"
    read userinput
    if [ "$userinput" = "y" ]; then
        rm -rf "$installdir"
        rm "$autostartfilepath"
    fi
fi