#!/bin/bash

# CPU Temperature Monitor
# Reads system thermal zones to display CPU temperature.

echo "CPU Temperature"
echo "---------------"

FOUND=0

# Method 1: sensors command
if command -v sensors &> /dev/null; then
    sensors | grep -iE "Core|Package|Tdie|Tctl"
    FOUND=1
fi

# Method 2: Thermal zones in /sys/class
if [ $FOUND -eq 0 ]; then
    for zone in /sys/class/thermal/thermal_zone*; do
        TYPE=$(cat "$zone/type")
        TEMP=$(cat "$zone/temp")
        # Convert millidegrees to degrees
        TEMP_C=$((TEMP / 1000))
        echo "$TYPE: ${TEMP_C}°C"
        FOUND=1
    done
fi

if [ $FOUND -eq 0 ]; then
    echo "Could not read temperature sensors."
fi
