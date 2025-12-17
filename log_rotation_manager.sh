#!/bin/bash

# Log Rotation Manager
# Rotates logs in a specified directory: compresses old logs and deletes very old ones.
# Customize retention days and size thresholds.

LOG_DIR=$1
RETENTION_DAYS=30
MAX_SIZE_MB=50

if [ -z "$LOG_DIR" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' not found."
    exit 1
fi

echo "Managing logs in '$LOG_DIR'..."

# 1. Compress logs larger than MAX_SIZE_MB (excluding already compressed .gz files)
find "$LOG_DIR" -type f -name "*.log" ! -name "*.gz" -size +${MAX_SIZE_MB}M | while read -r FILE; do
    echo "Compressing large file: $FILE"
    gzip "$FILE"
done

# 2. Delete logs (compressed or plain) older than RETENTION_DAYS
echo "Deleting logs older than $RETENTION_DAYS days..."
find "$LOG_DIR" -type f \( -name "*.log" -o -name "*.gz" \) -mtime +$RETENTION_DAYS -print -delete

echo "Log rotation completed."
