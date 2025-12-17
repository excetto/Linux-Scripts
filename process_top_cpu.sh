#!/bin/bash

# Top CPU Processes
# Lists the processes using the most CPU on the system.

COUNT="${1:-10}"

echo "Top $COUNT processes by CPU usage:"
echo "----------------------------------"
ps aux --sort=-%cpu | head -n "$((COUNT + 1))"


