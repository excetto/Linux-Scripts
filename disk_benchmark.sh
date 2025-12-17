#!/bin/bash

# Disk Benchmark Tool
# Tests disk read/write performance

# Check if hdparm is installed
if ! command -v hdparm &> /dev/null; then
    echo "hdparm not found. Installing..."
    sudo apt-get install -y hdparm
fi

echo "Disk Benchmark Tool"
echo "-------------------"

# Get list of disks
DISKS=$(lsblk -d -o NAME | grep -v NAME)

for DISK in $DISKS; do
    echo "Benchmarking /dev/$DISK:"
    sudo hdparm -Tt /dev/$DISK
    echo ""
done

echo "-------------------"
echo "Disk benchmark completed"
