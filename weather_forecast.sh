#!/bin/bash

# Weather Forecast
# Checks the weather for a specified location using wttr.in.

LOCATION=${1:-}

if ! command -v curl &> /dev/null; then
    echo "Error: curl is required."
    exit 1
fi

# If location is empty, wttr.in auto-detects based on IP
curl "wttr.in/$LOCATION?0"
