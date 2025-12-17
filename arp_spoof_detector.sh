#!/bin/bash

# ARP Spoof Detector
# Monitors the ARP table for multiple IP addresses associated with the same MAC address.

echo "ARP Spoofing Detector"
echo "---------------------"
echo "Monitoring ARP table... (Press Ctrl+C to stop)"

while true; do
    # Get ARP table, skip headers
    # Format: IP HW_TYPE FLAGS MAC MASK DEVICE
    
    # Check for duplicate MACs (excluding incomplete entries)
    DUPLICATES=$(arp -n | grep -v "incomplete" | awk '{print $3}' | sort | uniq -d)
    
    if [ -n "$DUPLICATES" ]; then
        for MAC in $DUPLICATES; do
            echo "[ALERT] Possible ARP Spoofing detected!"
            echo "MAC Address $MAC is claiming multiple IPs:"
            arp -n | grep "$MAC"
            echo "----------------------------------------"
        done
    fi
    
    sleep 5
done
