#!/bin/bash

uvicorn main:app --port 8065 --log-config ./logconfig.ini &
tail -f ./logfile.log