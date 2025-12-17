#!/bin/bash

# Local HTTP Server
# Starts a simple HTTP server in the current directory using Python.

PORT=${1:-8000}

if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    exit 1
fi

IP=$(hostname -I | cut -d' ' -f1)

echo "Starting HTTP server on port $PORT..."
echo "Access at: http://$IP:$PORT"
echo "Press Ctrl+C to stop."

python3 -m http.server "$PORT"
