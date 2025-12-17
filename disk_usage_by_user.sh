#!/bin/bash

# Disk Usage by User
# Shows disk usage breakdown by user

echo "Disk Usage by User"
echo "-------------------"

# Show disk usage by user in /home directory
if [ -d "/home" ]; then
    echo "Home directory usage:"
    sudo du -sh /home/* 2>/dev/null | sort -rh
    echo ""
fi

# Show disk usage by user in current directory
echo "Current directory usage by user:"
sudo du -sh * 2>/dev/null | sort -rh

echo "-------------------"
echo "Disk usage by user completed"
