#!/bin/bash

# Backup Directory
# Creates a timestamped tar.gz archive of a specified directory.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <source_directory> [destination_directory]"
    exit 1
fi

SOURCE_DIR=$1
DEST_DIR=${2:-$(pwd)}
DATE=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_$(basename "$SOURCE_DIR")_$DATE.tar.gz"

echo "Backing up '$SOURCE_DIR' to '$DEST_DIR/$ARCHIVE_NAME'..."

tar -czf "$DEST_DIR/$ARCHIVE_NAME" "$SOURCE_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed."
fi
