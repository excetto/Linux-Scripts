#!/bin/bash

# Zombie Parent Hunter
# Finds zombie processes (defunct) and identifies their parent process ID (PPID).

echo "Scanning for Zombie Processes..."
echo "------------------------------"

ZOMBIES=$(ps -eo stat,ppid,pid,comm | grep -w "Z")

if [ -z "$ZOMBIES" ]; then
    echo "No zombie processes found."
else
    echo "STAT PPID   PID  COMMAND"
    echo "$ZOMBIES"
    echo "------------------------------"
    echo "To clean up, you usually need to kill the PARENT (PPID)."
fi
