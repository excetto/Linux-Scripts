#!/bin/bash

# Cron Job Viewer
# Lists scheduled cron jobs for all users (requires root).

echo "System Cron Job Viewer"
echo "----------------------"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

# List system-wide cron jobs
echo "System-wide (/etc/crontab):"
if [ -f /etc/crontab ]; then
    grep -v "^#" /etc/crontab
fi

echo ""
echo "User Cron Jobs:"
echo "---------------"

# Loop through all users
cut -d: -f1 /etc/passwd | while read -r USER; do
    if crontab -u "$USER" -l &>/dev/null; then
        echo "User: $USER"
        crontab -u "$USER" -l | grep -v "^#"
        echo "..."
    fi
done
