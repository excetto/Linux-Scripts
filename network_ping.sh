#!/bin/bash

# Network Ping Tool
# Pings a specified host and provides basic connectivity information

# Check if host argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <hostname_or_ip>"
    echo "Example: $0 google.com"
    exit 1
fi

HOST=$1
COUNT=5

echo "Pinging $HOST $COUNT times..."
echo "--------------------------------"

ping -c $COUNT $HOST

if [ $? -eq 0 ]; then
    echo "--------------------------------"
    echo "✅ Connection successful to $HOST"
else
    echo "--------------------------------"
    echo "❌ Connection failed to $HOST"
fi
