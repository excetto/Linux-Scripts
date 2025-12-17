#!/bin/bash

# Disk Usage Analyzer
# Shows detailed disk usage information for all mounted filesystems

echo "Disk Usage Analysis"
echo "-------------------"

# Show overall disk usage
df -h

echo ""
echo "Largest Directories in / (top 10):"
echo "-----------------------------------"

# Find largest directories in root
sudo du -h / | sort -rh | head -10

echo ""
echo "Disk usage analysis completed"
