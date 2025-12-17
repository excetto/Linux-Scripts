#!/bin/bash

# Service Auto-Healer
# Checks if specified services are running. If not, attempts to restart them.
# Stops trying after a maximum number of attempts to prevent flapping.

SERVICES=("nginx" "mysql" "docker") # List services to monitor
MAX_RETRIES=3
STATE_FILE="/tmp/service_healer_state"

if [ "$EUID" -ne 0 ]; then
    echo "Error: This script requires root permissions to restart services."
    exit 1
fi

# Initialize state file
touch "$STATE_FILE"

for SERVICE in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$SERVICE"; then
        echo "⚠️ Service '$SERVICE' is DOWN."
        
        # Get current retry count
        RETRIES=$(grep "^$SERVICE:" "$STATE_FILE" | cut -d: -f2)
        RETRIES=${RETRIES:-0}

        if [ "$RETRIES" -lt "$MAX_RETRIES" ]; then
            echo "Attempting restart ($((RETRIES+1))/$MAX_RETRIES)..."
            systemctl start "$SERVICE"
            
            if systemctl is-active --quiet "$SERVICE"; then
                echo "✅ Service '$SERVICE' recovered successfully."
                # Reset counter on success
                sed -i "/^$SERVICE:/d" "$STATE_FILE"
            else
                echo "❌ Restart failed."
                # Increment counter
                sed -i "/^$SERVICE:/d" "$STATE_FILE"
                echo "$SERVICE:$((RETRIES+1))" >> "$STATE_FILE"
            fi
        else
            echo "⛔ Max retries reached for '$SERVICE'. Manual intervention required."
        fi
    else
        # Service is healthy, ensure retry count is clear
        if grep -q "^$SERVICE:" "$STATE_FILE"; then
            sed -i "/^$SERVICE:/d" "$STATE_FILE"
        fi
        echo "✅ Service '$SERVICE' is running."
    fi
done
