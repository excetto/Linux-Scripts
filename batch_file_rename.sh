#!/bin/bash

# Batch File Renamer
# Adds a prefix or suffix to all files in the current directory.

echo "Batch File Renamer"
echo "------------------"

read -p "Enter text to add: " TEXT
read -p "Add as (p)refix or (s)uffix? " POS
read -p "Dry run? (y/n) [y]: " DRY_RUN
DRY_RUN=${DRY_RUN:-y}

for FILE in *; do
    # Skip directories and the script itself
    [ -d "$FILE" ] && continue
    [ "$FILE" == "$(basename "$0")" ] && continue

    FILENAME="${FILE%.*}"
    EXT="${FILE##*.}"
    
    # Handle files without extension
    if [ "$FILENAME" == "$EXT" ]; then
        EXT=""
    else
        EXT=".$EXT"
    fi

    if [ "$POS" == "p" ]; then
        NEW_NAME="${TEXT}${FILENAME}${EXT}"
    elif [ "$POS" == "s" ]; then
        NEW_NAME="${FILENAME}${TEXT}${EXT}"
    else
        echo "Invalid position."
        exit 1
    fi

    if [[ $DRY_RUN =~ ^[Yy]$ ]]; then
        echo "[Dry Run] Would rename '$FILE' to '$NEW_NAME'"
    else
        mv -v "$FILE" "$NEW_NAME"
    fi
done
