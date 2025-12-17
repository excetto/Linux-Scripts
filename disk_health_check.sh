#!/bin/bash

# Disk Health Check
# Checks SMART status and basic health of disks

echo "Disk Health Check"
echo "-----------------"

# Check if smartctl is installed
if ! command -v smartctl &> /dev/null; then
    echo "smartmontools not found. Installing..."
    sudo apt-get install -y smartmontools
fi

# Get list of disks
DISKS=$(lsblk -d -o NAME | grep -v NAME)

for DISK in $DISKS; do
    echo "Checking /dev/$DISK:"
    sudo smartctl -H /dev/$DISK
    echo ""
done

echo "-----------------"
echo "Disk health check completed"
