#!/bin/bash

# Large File Shredder
# Securely deletes a file by overwriting it multiple times before removing.
# Uses 'shred' if available, otherwise manual dd fallback.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_to_shred>"
    exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

echo "WARNING: '$FILE' will be IRRECOVERABLY deleted."
read -p "Type 'DELETE' to confirm: " CONFIRM

if [ "$CONFIRM" != "DELETE" ]; then
    echo "Operation cancelled."
    exit 0
fi

if command -v shred &> /dev/null; then
    # -u: remove after overwriting
    # -z: add a final overwrite with zeros to hide shredding
    # -n 3: overwrite 3 times
    echo "Shredding with 3 passes..."
    shred -u -z -n 3 -v "$FILE"
else
    echo "'shred' not found. Using 'dd' fallback (slower)..."
    FILESIZE=$(stat -c%s "$FILE")
    
    echo "Pass 1: Random data..."
    dd if=/dev/urandom of="$FILE" bs="$FILESIZE" count=1 conv=notrunc status=none
    
    echo "Pass 2: Zeros..."
    dd if=/dev/zero of="$FILE" bs="$FILESIZE" count=1 conv=notrunc status=none
    
    rm -v "$FILE"
fi

echo "File destroyed."
