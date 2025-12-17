#!/bin/bash

# Mount Information
# Shows detailed information about mounted filesystems

echo "Mounted Filesystems Information"
echo "-------------------------------"

# Show mounted filesystems with detailed info
mount | column -t

echo ""
echo "Filesystem Types Summary:"
echo "-------------------------"

# Show filesystem types
df -T | awk 'NR==1 {print; next} {print $1, $2}' | column -t

echo "-------------------------------"
echo "Mount information completed"
