#!/bin/bash

# Directory Synchronizer
# Syncs source directory to destination using rsync.

if [ $# -lt 2 ]; then
    echo "Usage: $0 <source_dir> <dest_dir>"
    exit 1
fi

SRC=$1
DEST=$2

if ! command -v rsync &> /dev/null; then
    echo "Error: rsync is not installed."
    exit 1
fi

echo "Syncing '$SRC' to '$DEST'..."
# -a: archive mode, -v: verbose, --delete: remove files in dest not in src
rsync -av --delete "$SRC/" "$DEST/"

echo "Sync completed."
