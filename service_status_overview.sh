#!/bin/bash

# Service Status Overview
# Shows the status of failed and running systemd services.

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Error: systemctl is not available. This script requires systemd."
    exit 1
fi

echo "Failed services:"
echo "----------------"
systemctl --failed || echo "No failed services."

echo ""
echo "Running services (top 20):"
echo "--------------------------"
systemctl list-units --type=service --state=running | head -n 23


