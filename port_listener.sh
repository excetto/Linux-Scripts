#!/bin/bash

# Port Listener Check
# Identifies the process listening on a specific port.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <port_number>"
    exit 1
fi

PORT=$1

echo "Checking for process on port $PORT..."

if command -v lsof &> /dev/null; then
    sudo lsof -i :$PORT
elif command -v netstat &> /dev/null; then
    sudo netstat -nlp | grep ":$PORT "
elif command -v ss &> /dev/null; then
    sudo ss -lptn "sport = :$PORT"
else
    echo "Error: lsof, netstat, or ss commands not found."
    exit 1
fi
