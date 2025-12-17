#!/bin/bash

# Code Line Counter
# Recursively counts lines of code for specific file extensions in a directory.

DIR=${1:-.}
EXTENSIONS="sh py js java c cpp h go rs ts html css"

echo "Counting lines of code in '$DIR'..."
echo "-----------------------------------"

TOTAL=0

for EXT in $EXTENSIONS; do
    COUNT=$(find "$DIR" -name "*.$EXT" -type f -exec cat {} + 2>/dev/null | wc -l)
    if [ "$COUNT" -gt 0 ]; then
        echo ".$EXT files: $COUNT lines"
        TOTAL=$((TOTAL + COUNT))
    fi
done

echo "-----------------------------------"
echo "Total Lines of Code: $TOTAL"
