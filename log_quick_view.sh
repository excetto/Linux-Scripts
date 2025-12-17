#!/bin/bash

# Log Quick View
# Displays the last N lines from common system logs for quick troubleshooting.

LINES="${1:-50}"

echo "Showing last $LINES lines from common logs (if present)..."
echo "-----------------------------------------------------------"

LOG_FILES=(
    "/var/log/syslog"
    "/var/log/messages"
    "/var/log/auth.log"
    "/var/log/secure"
)

for LOG in "${LOG_FILES[@]}"; do
    if [ -f "$LOG" ]; then
        echo ""
        echo "=== $LOG ==="
        tail -n "$LINES" "$LOG"
    fi
done

if command -v journalctl >/dev/null 2>&1; then
    echo ""
    echo "=== journalctl (last $LINES lines) ==="
    journalctl -n "$LINES"
fi

echo ""
echo "Log quick view completed."


