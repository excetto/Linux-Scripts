#!/bin/bash

# SSL Cert Expiry Check
# Checks the expiration date of an SSL certificate for a domain.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain_name> [port]"
    echo "Example: $0 google.com 443"
    exit 1
fi

DOMAIN=$1
PORT=${2:-443}

echo "Checking SSL certificate for $DOMAIN:$PORT..."

END_DATE=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN":"$PORT" 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

if [ -z "$END_DATE" ]; then
    echo "Error: Could not retrieve certificate."
    exit 1
fi

echo "Expiry Date: $END_DATE"

# Calculate days remaining (requires date command capability)
if date -d "$END_DATE" >/dev/null 2>&1; then
    EXPIRY_EPOCH=$(date -d "$END_DATE" +%s)
    CURRENT_EPOCH=$(date +%s)
    DAYS_LEFT=$(( (EXPIRY_EPOCH - CURRENT_EPOCH) / 86400 ))
    echo "Days Remaining: $DAYS_LEFT"
fi
