#!/bin/bash

# Disk Usage Report
# Shows the largest directories under a given path to help identify where disk space is used.

TARGET_DIR="${1:-.}"
TOP_N="${2:-10}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a directory."
    echo "Usage: $0 [directory] [top_n]"
    echo "Example: $0 /var 15"
    exit 1
fi

echo "Disk usage report for: $TARGET_DIR"
echo "Showing top $TOP_N entries by size"
echo "----------------------------------------"

du -h --max-depth=1 "$TARGET_DIR" 2>/dev/null | sort -hr | head -n "$TOP_N"

echo "----------------------------------------"
echo "Tip: Pass a different directory and count, e.g. '$0 /home 20'"
