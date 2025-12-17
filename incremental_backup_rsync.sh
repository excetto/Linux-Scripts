#!/bin/bash

# Incremental Backup (Rsync Time Machine)
# Creates dated backups using hard links to save space.
# Structure: /backups/YYYY-MM-DD-HHMMSS/
#            /backups/latest -> symlink to most recent

SRC_DIR=$1
DEST_BASE=$2

if [ -z "$SRC_DIR" ] || [ -z "$DEST_BASE" ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

DATE=$(date +%Y-%m-%d-%H%M%S)
BACKUP_PATH="$DEST_BASE/$DATE"
LATEST_LINK="$DEST_BASE/latest"

echo "Starting backup of '$SRC_DIR' to '$BACKUP_PATH'..."

mkdir -p "$DEST_BASE"

# Rsync options:
# -a: archive
# --delete: mirror source (delete removed files in backup)
# --link-dest: hard link unchanged files from previous backup

RSYNC_OPTS="-a --delete"

if [ -d "$LATEST_LINK" ]; then
    echo "Found previous backup at $LATEST_LINK. Using for hard links."
    RSYNC_OPTS="$RSYNC_OPTS --link-dest=$LATEST_LINK"
fi

rsync $RSYNC_OPTS "$SRC_DIR/" "$BACKUP_PATH/"

if [ $? -eq 0 ]; then
    echo "Backup successful."
    # Update 'latest' symlink
    rm -f "$LATEST_LINK"
    ln -s "$BACKUP_PATH" "$LATEST_LINK"
    echo "Symlink 'latest' updated."
else
    echo "Backup failed with error code $?."
fi
