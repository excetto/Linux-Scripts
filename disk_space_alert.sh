#!/bin/bash

# Disk Space Alert
# Monitors disk space and alerts when thresholds are exceeded

THRESHOLD=90  # Alert when disk usage exceeds this percentage

echo "Disk Space Monitoring"
echo "----------------------"

# Check all mounted filesystems
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output; do
    USAGE=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
    PARTITION=$(echo $output | awk '{ print $2 }')

    if [ $USAGE -ge $THRESHOLD ]; then
        echo "⚠️  WARNING: Partition $PARTITION is at ${USAGE}% usage"
    else
        echo "✅ Partition $PARTITION is at ${USAGE}% usage"
    fi
done

echo "----------------------"
echo "Disk space monitoring completed"
