#!/bin/bash
wget -O ./mfl-server.zip "https://github.com/soumas/model-flight-logbook/releases/download/mfl-$1/mfl-server.zip" && unzip -o mfl-server.zip && rm mfl-server.zip