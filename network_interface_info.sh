#!/bin/bash

# Network Interface Information
# Displays detailed information about network interfaces

echo "Network Interface Information"
echo "----------------------------"

# Get all network interfaces
INTERFACES=$(ip -o link show | awk -F': ' '{print $2}')

for IFACE in $INTERFACES; do
    echo "Interface: $IFACE"
    echo "  MAC Address: $(ip link show $IFACE | awk '/link\/ether/ {print $2}')"
    echo "  IP Address: $(ip -4 addr show $IFACE | awk '/inet/ {print $2}')"
    echo "  Status: $(ip link show $IFACE | awk '/state/ {print $9}')"
    echo "  TX Bytes: $(cat /sys/class/net/$IFACE/statistics/tx_bytes)"
    echo "  RX Bytes: $(cat /sys/class/net/$IFACE/statistics/rx_bytes)"
    echo ""
done

echo "----------------------------"
echo "Network interface scan completed"
