#!/bin/bash

# Top Memory Processes
# Lists the processes using the most memory on the system.

COUNT="${1:-10}"

echo "Top $COUNT processes by memory usage:"
echo "-------------------------------------"
ps aux --sort=-%mem | head -n "$((COUNT + 1))"


