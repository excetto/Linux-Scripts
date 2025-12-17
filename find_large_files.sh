#!/bin/bash

# Large File Finder
# Finds files larger than specified size in a directory

# Check if arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory> <size_in_MB>"
    echo "Example: $0 /home 100"
    exit 1
fi

DIRECTORY=$1
SIZE_MB=$2

echo "Finding files larger than ${SIZE_MB}MB in $DIRECTORY"
echo "---------------------------------------------------"

# Find large files
find $DIRECTORY -type f -size +${SIZE_MB}M -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'

echo "---------------------------------------------------"
echo "Large file search completed"
