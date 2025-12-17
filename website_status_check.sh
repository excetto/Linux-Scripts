#!/bin/bash

# Website Status Checker
# Checks a list of websites to see if they are up (HTTP 200).

SITES=("google.com" "github.com" "stackoverflow.com")

# Allow passing a file with sites as argument
if [ -f "$1" ]; then
    mapfile -t SITES < "$1"
fi

echo "Checking Website Status..."
echo "------------------------"

for SITE in "${SITES[@]}"; do
    if [ -z "$SITE" ]; then continue; fi

    # Ensure protocol exists
    if [[ ! "$SITE" =~ ^http ]]; then
        URL="https://$SITE"
    else
        URL="$SITE"
    fi

    STATUS=$(curl -o /dev/null -s -w "%{http_code}" --connect-timeout 3 "$URL")

    if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 301 ] || [ "$STATUS" -eq 302 ]; then
        echo "✅ $SITE is UP (Status: $STATUS)"
    else
        echo "❌ $SITE is DOWN or Unreachable (Status: $STATUS)"
    fi
done
