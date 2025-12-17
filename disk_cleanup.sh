#!/bin/bash

# Disk Cleanup Tool
# Cleans up common temporary files and caches

echo "Disk Cleanup Tool"
echo "-----------------"

# Clean package manager cache
echo "Cleaning package manager cache..."
sudo apt-get clean

# Clean thumbnail cache
echo "Cleaning thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

# Clean old logs
echo "Cleaning old system logs..."
sudo journalctl --vacuum-time=7d

# Clean temporary files
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean old kernels (keep current and one previous)
echo "Cleaning old kernels..."
sudo apt-get autoremove --purge

echo "-----------------"
echo "Disk cleanup completed"
echo "Freed space: $(df -h / | awk 'NR==2 {print $4}') available"
