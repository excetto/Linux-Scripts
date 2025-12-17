#!/bin/bash

# Disk ISO Burner
# Safely writes an ISO image to a USB drive using 'dd' with safety checks.

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 <iso_file> <target_device>"
    echo "Example: $0 ubuntu.iso /dev/sdb"
    exit 1
fi

ISO=$1
DRIVE=$2

if [ ! -f "$ISO" ]; then
    echo "Error: ISO file '$ISO' not found."
    exit 1
fi

if [ ! -b "$DRIVE" ]; then
    echo "Error: Target '$DRIVE' is not a block device."
    exit 1
fi

echo "WARNING: ALL DATA ON '$DRIVE' WILL BE DESTROYED!"
lsblk -d -o NAME,MODEL,SIZE,TYPE "$DRIVE"
echo "------------------------------------------------"
read -p "Type 'DESTROY' to continue: " CONFIRM

if [ "$CONFIRM" == "DESTROY" ]; then
    echo "Writing image. Please wait..."
    dd if="$ISO" of="$DRIVE" bs=4M status=progress oflag=sync
    echo "Done."
else
    echo "Operation cancelled."
fi
