#!/bin/bash

# Disk Partition Information
# Shows detailed partition information for all disks

echo "Disk Partition Information"
echo "--------------------------"

# Show partition information
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL,UUID | column -t

echo ""
echo "Detailed Partition Information:"
echo "-------------------------------"

# Show detailed partition info for each disk
DISKS=$(lsblk -d -o NAME | grep -v NAME)

for DISK in $DISKS; do
    echo "/dev/$DISK partitions:"
    sudo fdisk -l /dev/$DISK | grep -E '^Disk|/dev/'
    echo ""
done

echo "--------------------------"
echo "Partition information completed"
