#!/bin/bash

# Find Recent Files
# Lists files modified in the last N minutes under a given directory.

TARGET_DIR="${1:-.}"
MINUTES="${2:-60}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a directory."
    echo "Usage: $0 [directory] [minutes]"
    echo "Example: $0 /var/log 30"
    exit 1
fi

echo "Files in '$TARGET_DIR' modified in the last $MINUTES minutes:"
echo "-------------------------------------------------------------"

find "$TARGET_DIR" -type f -mmin "-$MINUTES" -print 2>/dev/null


