#!/bin/bash

# System Resource Monitor
# Displays a quick summary of CPU, memory, and disk usage for the current system.

echo "System Resource Summary - $(date)"
echo "---------------------------------"

echo ""
echo "Uptime and load averages:"
uptime

echo ""
echo "CPU usage (top 5 processes by CPU):"
ps aux --sort=-%cpu | head -n 6

echo ""
echo "Memory usage:"
if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "The 'free' command is not available on this system."
fi

echo ""
echo "Disk usage (top-level mount points):"
df -h -x tmpfs -x devtmpfs

echo ""
echo "System resource summary completed."


