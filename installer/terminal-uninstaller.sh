#!/bin/bash

installdir="mfl-terminal"
autostartfilename="mfl-terminal.desktop"
autostartfilepath="$HOME/.config/autostart/$autostartfilename"

if [ -d "$installdir" ]; then
    rm -rf "$installdir"
    rm "$autostartfilepath"
else
    echo "Directory $installdir not found."
fi
