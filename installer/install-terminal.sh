#!/bin/bash

installdir="mfl-terminal"
tmpfilesdir="installertmp"
autostartfilename="mfl-terminal.desktop"
autostartfilepath="$HOME/.config/autostart/"

if [ ! -d "$installdir" ]; then

    # create target directory
    mkdir "$installdir"
    cd "$installdir"

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

    # download, unzip and cleanup latest terminal release
    wget https://github.com/soumas/model-flight-logbook/releases/latest/download/mfl-terminal-linux-$arch.zip && unzip -o mfl-terminal-linux-$arch.zip && rm mfl-terminal-linux-$arch.zip

    # create run-terminal script
    wget -P $tmpfilesdir https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/files/run-terminal.sh.tmpl
    cp "./$tmpfilesdir/run-terminal.sh.tmpl" ./run-terminal.sh
    sed -i "s|ROOTPATH|${PWD//\//\\/}|g" ./run-terminal.sh
    chmod +x ./run-terminal.sh

    # prepare autostart entry
    wget -P $tmpfilesdir https://github.com/soumas/model-flight-logbook/raw/refs/heads/main/installer/files/mfl-terminal.desktop.tmpl    
    cp "./$tmpfilesdir/mfl-terminal.desktop.tmpl" ./$autostartfilename
    startcommand="$PWD/run-terminal.sh"
    sed -i "s|COMMAND|$startcommand|g" ./$autostartfilename

    # install autostart entry
    mkdir -p "$autostartfilepath"
    mv ./$autostartfilename "$autostartfilepath/$autostartfilename"

    # cleanup
    rm -rf $tmpfilesdir

    # start terminal
    ./run-terminal.sh &
else
    echo "Directory $installdir already exists. Do you want to uninstall the terminal? (y/n)"
    read userinput
    if [ "$userinput" = "y" ]; then
        rm -rf "$installdir"
        rm "$autostartfilepath/$autostartfilename"
    fi
fi