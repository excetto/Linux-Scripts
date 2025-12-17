#!/bin/bash

# Network Port Scanner
# Scans common ports on a specified host

# Check if host argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <hostname_or_ip>"
    echo "Example: $0 localhost"
    exit 1
fi

HOST=$1
PORTS=(21 22 23 25 53 80 110 143 443 3306 3389 8080)

echo "Scanning common ports on $HOST..."
echo "--------------------------------"

for PORT in "${PORTS[@]}"; do
    if timeout 1 bash -c "echo > /dev/tcp/$HOST/$PORT" 2>/dev/null; then
        echo "Port $PORT: ✅ Open"
    else
        echo "Port $PORT: ❌ Closed"
    fi
done

echo "--------------------------------"
echo "Port scan completed"
