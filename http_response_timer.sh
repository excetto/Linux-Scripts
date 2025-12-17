#!/bin/bash

# HTTP Response Timer
# Measures the time taken for different phases of an HTTP request.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

URL=$1

if ! command -v curl &> /dev/null; then
    echo "Error: curl is required."
    exit 1
fi

echo "Testing latency to $URL..."
echo "---------------------------------"

curl -w "DNS Lookup: %{time_namelookup}s\nConnect:    %{time_connect}s\nAppConnect: %{time_appconnect}s\nStartTransfer: %{time_starttransfer}s\n\nTotal Time:  %{time_total}s\n" -o /dev/null -s "$URL"
