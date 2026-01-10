#!/bin/bash

action=$1
component=$2
port=$3

case $action in
    install)
    case $component in
        server)
            ./server-installer.sh $port
            ;;
        terminal)
            ./terminal-installer.sh
            ;;
        *)
            echo "Component not defined. Use [server|terminal] as second argument."
            ;;
    esac
    ;;
    uninstall)
    case $component in
        server)
            ./server-uninstaller.sh $port
            ;;
        terminal)
            ./terminal-uninstaller.sh
            ;;
        *)
            echo "Component not defined. Use [server|terminal] as second argument."
            ;;
    esac
    ;;
    update)
    case $component in
        server)
            ./server-updater.sh $port
            ;;
        terminal)
            ./terminal-updater.sh
            ;;
        *)
            echo "Component not defined. Use [server|terminal] as second argument."
            ;;
    esac
    ;;    
    *)
    echo "Usage: ./mfl-installer.sh [install|uninstall] [server|terminal] [port]"
    ;;
esac