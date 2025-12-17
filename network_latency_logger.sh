#!/bin/bash

# Network Latency Logger
# Pings a target repeatedly and logs timestamp, latency, and packet loss to a CSV file.
# Useful for diagnosing intermittent network issues.

TARGET=${1:-"8.8.8.8"}
LOG_FILE="network_latency.csv"
INTERVAL=5

echo "Logging latency to $TARGET every $INTERVAL seconds..."
echo "Press Ctrl+C to stop."

# Initialize CSV Header if not exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Target,Latency_ms,Status" > "$LOG_FILE"
fi

trap "echo 'Logging stopped.'; exit" SIGINT

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    
    # Ping 1 packet, wait max 1 second
    RESULT=$(ping -c 1 -W 1 "$TARGET" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        # Extract time=XX.X ms
        LATENCY=$(echo "$RESULT" | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}')
        echo "$TIMESTAMP,$TARGET,$LATENCY,OK" >> "$LOG_FILE"
        echo "[$TIMESTAMP] OK: ${LATENCY}ms"
    else
        echo "$TIMESTAMP,$TARGET,-1,TIMEOUT" >> "$LOG_FILE"
        echo "[$TIMESTAMP] TIMEOUT"
    fi
    
    sleep "$INTERVAL"
done
