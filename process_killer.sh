#!/bin/bash

# Process Killer
# Finds processes matching a name and kills them interactively.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <process_name_pattern>"
    exit 1
fi

PATTERN=$1

echo "Searching for processes matching '$PATTERN'..."
# Exclude the current script's PID ($$) to prevent self-termination
PIDS=$(pgrep -f "$PATTERN" | grep -v $$)

if [ -z "$PIDS" ]; then
    echo "No matching processes found."
    exit 0
fi

echo "Found the following PIDs:"
ps -fp $PIDS

echo ""
read -p "Do you want to kill these processes? (y/n): " CONFIRM

if [[ $CONFIRM =~ ^[Yy]$ ]]; then
    kill $PIDS
    echo "Signal sent to processes."
else
    echo "Operation cancelled."
fi
