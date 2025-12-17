#!/bin/bash

# Directory Change Watcher
# Uses inotifywait to monitor a directory for changes in real-time.
# Requires 'inotify-tools' package.

DIR_TO_WATCH=${1:-.}

if ! command -v inotifywait &> /dev/null; then
    echo "Error: 'inotifywait' is not installed."
    echo "Install via: sudo apt install inotify-tools (Debian/Ubuntu) or yum install inotify-tools (RHEL)"
    exit 1
fi

echo "Watching '$DIR_TO_WATCH' for events..."
echo "Press Ctrl+C to stop."

# -m: monitor continuously
# -r: recursive
# -e: events to listen for
inotifywait -m -r -e create,delete,modify,move --format '%w%f %e' "$DIR_TO_WATCH" | while read -r FILE EVENT; do
    TIMESTAMP=$(date "+%H:%M:%S")
    echo "[$TIMESTAMP] $EVENT: $FILE"
    
    # Optional: Add custom logic here
    # e.g., if [[ "$EVENT" == "CREATE" ]]; then ./process_new_file.sh "$FILE"; fi
done
