#!/bin/bash

# Local Network Scanner
# Scans the local network (ARP scan) to find connected devices.
# Note: Works best with 'arp-scan' installed, falls back to ping sweep.

echo "Local Network Scanner"
echo "---------------------"

if command -v arp-scan &> /dev/null; then
    echo "Using arp-scan (requires sudo)..."
    sudo arp-scan --localnet
else
    echo "'arp-scan' not found. Performing simple ping sweep..."
    # Guess subnet (simplistic)
    SUBNET=$(ip route | grep default | awk '{print $3}' | cut -d. -f1-3)
    if [ -z "$SUBNET" ]; then
        echo "Could not detect subnet."
        exit 1
    fi
    echo "Scanning ${SUBNET}.1-254..."
    for i in {1..254}; do
        timeout 0.2 ping -c 1 "${SUBNET}.$i" >/dev/null 2>&1 && echo "${SUBNET}.$i is UP" &
    done
    wait
fi
