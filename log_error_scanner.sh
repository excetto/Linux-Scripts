#!/bin/bash

# Log Error Scanner
# Scans a specified log file for common error keywords.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE=$1

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

echo "Scanning '$LOG_FILE' for errors..."
echo "----------------------------------"

grep -nEi "error|fail|exception|fatal|critical|warning" "$LOG_FILE" | head -n 20

MATCH_COUNT=$(grep -cEi "error|fail|exception|fatal|critical|warning" "$LOG_FILE")

echo "----------------------------------"
if [ "$MATCH_COUNT" -gt 20 ]; then
    echo "... and $((MATCH_COUNT - 20)) more matches."
fi
echo "Total matches found: $MATCH_COUNT"
