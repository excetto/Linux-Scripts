#!/bin/bash

# Service Checker
# Checks if a specified service is active and running.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

SERVICE=$1

echo "Checking status of service: $SERVICE"
echo "-----------------------------------"

if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ Service '$SERVICE' is RUNNING."
    echo "Main PID: $(systemctl show --property MainPID --value "$SERVICE")"
    echo "Memory: $(systemctl show --property MemoryCurrent --value "$SERVICE" | awk '{print int($1/1024/1024)"MB"}')"
else
    echo "❌ Service '$SERVICE' is NOT running."
    echo "Current Status: $(systemctl is-enabled "$SERVICE" 2>/dev/null || echo "Unknown")"
fi
