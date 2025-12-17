#!/bin/bash

# File Integrity Monitor
# Generates SHA256 hashes of files in a directory and compares them to a baseline.
# Detects: Modified files, New files, Deleted files.

DB_FILE=".file_integrity.db"
TARGET_DIR=${1:-./important_files}

if [ ! -d "$TARGET_DIR" ]; then
    echo "Usage: $0 <directory_to_monitor>"
    exit 1
fi

CURRENT_HASHES="/tmp/fim_current.tmp"

echo "Scanning '$TARGET_DIR'..."

# Generate current hashes
find "$TARGET_DIR" -type f -exec sha256sum {} + | sort > "$CURRENT_HASHES"

# If baseline database doesn't exist, create it
if [ ! -f "$DB_FILE" ]; then
    echo "First run detected. Creating baseline database at '$DB_FILE'..."
    cp "$CURRENT_HASHES" "$DB_FILE"
    echo "Baseline created. Future runs will compare against this state."
    rm "$CURRENT_HASHES"
    exit 0
fi

echo "Comparing against baseline..."
echo "-----------------------------"

# Use diff to compare
CHANGES=$(diff "$DB_FILE" "$CURRENT_HASHES")

if [ -z "$CHANGES" ]; then
    echo "✅ No changes detected."
else
    echo "⚠️ CHANGES DETECTED!"
    echo "$CHANGES" | grep "<" | awk '{$1=""; print "MISSING/MODIFIED (Baseline): " $0}'
    echo "$CHANGES" | grep ">" | awk '{$1=""; print "NEW/MODIFIED (Current):  " $0}'
    
    echo ""
    read -p "Update baseline to match current state? (y/n): " UPDATE
    if [[ "$UPDATE" =~ ^[Yy]$ ]]; then
        cp "$CURRENT_HASHES" "$DB_FILE"
        echo "Baseline updated."
    fi
fi

rm "$CURRENT_HASHES"
