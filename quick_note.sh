#!/bin/bash

# Quick Note Taker
# Appends a timestamped note to a 'notes.txt' file in the user's home directory.

NOTE_FILE="$HOME/notes.txt"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <note_text>"
    exit 1
fi

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$TIMESTAMP] $*" >> "$NOTE_FILE"

echo "Note saved to $NOTE_FILE"
