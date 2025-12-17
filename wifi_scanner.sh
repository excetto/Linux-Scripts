#!/bin/bash

# WiFi Network Scanner
# Scans for available WiFi networks and displays their signal strength.

echo "WiFi Network Scanner"
echo "--------------------"

if command -v nmcli &> /dev/null; then
    # NetworkManager CLI
    nmcli dev wifi list
elif command -v iwlist &> /dev/null; then
    # Legacy iwlist (needs interface, usually wlan0)
    INTERFACE=$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}' | head -n 1 | tr -d ' ') 
    # Fallback guess for interface if awk fails or complex setup
    [ -z "$INTERFACE" ] && INTERFACE="wlan0"
    
    sudo iwlist "$INTERFACE" scan | grep -E "ESSID|Signal"
else
    echo "Error: Neither 'nmcli' nor 'iwlist' found."
    exit 1
fi
