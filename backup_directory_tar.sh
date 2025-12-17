#!/bin/bash

# Directory Backup (tar.gz)
# Creates a timestamped tar.gz backup of a directory.

SOURCE_DIR="${1:-.}"
DEST_DIR="${2:-$HOME/backups}"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: '$SOURCE_DIR' is not a directory."
    echo "Usage: $0 [source_dir] [destination_dir]"
    echo "Example: $0 /etc /root/backups"
    exit 1
fi

mkdir -p "$DEST_DIR"

TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
BASENAME="$(basename "$SOURCE_DIR")"
ARCHIVE="$DEST_DIR/${BASENAME}_backup_${TIMESTAMP}.tar.gz"

echo "Creating backup of '$SOURCE_DIR' at '$ARCHIVE'..."
tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE_DIR")" "$BASENAME"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
    echo "File: $ARCHIVE"
else
    echo "Backup failed."
fi


