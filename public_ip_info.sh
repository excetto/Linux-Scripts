#!/bin/bash

# Public IP Info
# Retrieves and displays public IP address and geolocation details.

echo "Fetching Public IP Information..."
echo "---------------------------------"

if ! command -v curl &> /dev/null; then
    echo "Error: curl is required."
    exit 1
fi

# Use ipinfo.io API
RESPONSE=$(curl -s ipinfo.io)

IP=$(echo "$RESPONSE" | grep '"ip":' | cut -d'"' -f4)
CITY=$(echo "$RESPONSE" | grep '"city":' | cut -d'"' -f4)
REGION=$(echo "$RESPONSE" | grep '"region":' | cut -d'"' -f4)
COUNTRY=$(echo "$RESPONSE" | grep '"country":' | cut -d'"' -f4)
ORG=$(echo "$RESPONSE" | grep '"org":' | cut -d'"' -f4)

echo "IP Address:  $IP"
echo "Location:    $CITY, $REGION, $COUNTRY"
echo "ISP/Org:     $ORG"
