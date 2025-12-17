#!/bin/bash

# Duplicate File Finder
# Finds duplicate files in a directory based on content (MD5 hash).

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

TARGET_DIR=$1

echo "Scanning '$TARGET_DIR' for duplicates..."
echo "This might take a while for large directories."
echo "----------------------------------------------"

find "$TARGET_DIR" -type f ! -empty -exec md5sum {} + | sort | uniq -w32 -dD

echo "----------------------------------------------"
echo "Scan completed. Use 'rm' carefully on the results above."
