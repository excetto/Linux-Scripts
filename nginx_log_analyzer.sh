#!/bin/bash

# Nginx Log Analyzer
# Parses an Nginx access.log to show Top IPs, Top Status Codes, and Top 404s.

LOG_FILE=$1

if [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <access.log>"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi

echo "--- Top 10 IP Addresses ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10

echo ""
echo "--- Top HTTP Status Codes ---"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10

echo ""
echo "--- Top 10 Missing Paths (404) ---"
awk '($9 ~ /404/)' "$LOG_FILE" | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10

echo ""
echo "Analysis complete."
