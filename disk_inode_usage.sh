#!/bin/bash

# Disk Inode Usage
# Shows inode usage information for all filesystems

echo "Disk Inode Usage"
echo "----------------"

# Show inode usage
df -i

echo ""
echo "Filesystems with high inode usage:"
echo "-----------------------------------"

# Show filesystems with high inode usage
df -i | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output; do
    USAGE=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
    PARTITION=$(echo $output | awk '{ print $2 }')

    if [ $USAGE -ge 80 ]; then
        echo "⚠️  WARNING: Partition $PARTITION is at ${USAGE}% inode usage"
    else
        echo "✅ Partition $PARTITION is at ${USAGE}% inode usage"
    fi
done

echo "----------------"
echo "Inode usage check completed"
