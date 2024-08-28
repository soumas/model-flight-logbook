#!/bin/bash

uvicorn main:app --port 8065 --log-config ./logconfig-prod.ini