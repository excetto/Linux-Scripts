#!/bin/bash

# Temp Cleaner
# Cleans up temporary files from system and user directories to free up space.

echo "Temporary File Cleaner"
echo "----------------------"

if [ "$EUID" -ne 0 ]; then
    echo "Warning: Not running as root. Some directories may be skipped."
fi

# Clean User Cache
echo "Cleaning user cache (~/.cache)..."
rm -rf ~/.cache/* 2>/dev/null

# Clean /tmp (older than 7 days)
echo "Cleaning /tmp (files older than 7 days)..."
find /tmp -type f -atime +7 -delete 2>/dev/null

# Clean package manager cache if root
if [ "$EUID" -eq 0 ]; then
    if command -v apt-get &> /dev/null; then
        echo "Cleaning apt cache..."
        apt-get clean
        apt-get autoremove -y
    elif command -v dnf &> /dev/null; then
        echo "Cleaning dnf cache..."
        dnf clean all
    fi
fi

echo "Cleanup completed."
