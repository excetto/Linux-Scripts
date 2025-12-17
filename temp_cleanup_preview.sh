#!/bin/bash

# Temporary Files Cleanup (Preview)
# Shows files in /tmp older than N days and optionally deletes them.

DAYS="${1:-7}"
ACTION="${2:-preview}"  # preview or delete

echo "Looking for files in /tmp older than $DAYS days..."
echo "Mode: $ACTION"
echo "------------------------------------------"

find /tmp -type f -mtime "+$DAYS" -print 2>/dev/null | sed 's/^/FOUND: /'

if [ "$ACTION" = "delete" ]; then
    echo ""
    echo "Deleting files..."
    find /tmp -type f -mtime "+$DAYS" -delete 2>/dev/null
    echo "Cleanup completed."
else
    echo ""
    echo "Preview mode only. To delete files, run:"
    echo "$0 $DAYS delete"
fi


