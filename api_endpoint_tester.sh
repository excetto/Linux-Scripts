#!/bin/bash

# API Endpoint Tester
# Reads a list of URLs from a file and verifies they return HTTP 200.
# Input file format: One URL per line.

CONFIG_FILE=$1

if [ -z "$CONFIG_FILE" ]; then
    echo "Usage: $0 <urls_list.txt>"
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found."
    exit 1
fi

FAIL_COUNT=0
TOTAL_COUNT=0

echo "Starting API Tests..."
echo "---------------------"

while read -r URL; do
    # Skip comments/empty lines
    [[ "$URL" =~ ^# ]] && continue
    [ -z "$URL" ] && continue
    
    ((TOTAL_COUNT++))
    
    CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$URL")
    
    if [ "$CODE" -eq 200 ]; then
        echo "✅ [200] $URL"
    else
        echo "❌ [$CODE] $URL"
        ((FAIL_COUNT++))
    fi

done < "$CONFIG_FILE"

echo "---------------------"
echo "Tests: $TOTAL_COUNT | Failed: $FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
    exit 1
else
    exit 0
fi
