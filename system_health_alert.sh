#!/bin/bash

# System Health Alert
# Monitors CPU, RAM, and Disk usage. Sends an alert via Webhook or Email if thresholds are exceeded.
# Configuration: Set thresholds and webhook URL below.

# --- Configuration ---
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=90
WEBHOOK_URL="" # Paste your Slack/Discord webhook URL here
EMAIL_TO=""    # Or set an email address

# --- Functions ---

send_alert() {
    local message="$1"
    echo "[ALERT] $message"
    
    # Webhook alert
    if [ -n "$WEBHOOK_URL" ]; then
        if command -v curl &>/dev/null; then
            curl -H "Content-Type: application/json" -d "{\"text\": \"$message\"}" "$WEBHOOK_URL" 2>/dev/null
        fi
    fi

    # Email alert (requires mail command)
    if [ -n "$EMAIL_TO" ] && command -v mail &>/dev/null; then
        echo "$message" | mail -s "System Health Alert: $(hostname)" "$EMAIL_TO"
    fi
}

# --- Main Logic ---

# 1. CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    send_alert "High CPU Usage: ${CPU_USAGE}% on $(hostname)"
fi

# 2. RAM Usage
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
if [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ]; then
    send_alert "High Memory Usage: ${RAM_USAGE}% on $(hostname)"
fi

# 3. Disk Usage (Root partition)
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    send_alert "High Disk Usage: ${DISK_USAGE}% on root partition of $(hostname)"
fi

echo "Health check completed."
