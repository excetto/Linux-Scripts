#!/bin/bash

# Batch Image Converter
# Converts all images in the current directory from one format to another (e.g., jpg to png).
# Requires ImageMagick.

if [ $# -lt 2 ]; then
    echo "Usage: $0 <source_ext> <target_ext>"
    echo "Example: $0 jpg png"
    exit 1
fi

SRC_EXT=$1
DEST_EXT=$2

if ! command -v mogrify &> /dev/null; then
    echo "Error: ImageMagick (mogrify) is not installed."
    exit 1
fi

echo "Converting *.$SRC_EXT to *.$DEST_EXT..."
mkdir -p converted
cp *.$SRC_EXT converted/ 2>/dev/null

if [ $? -ne 0 ]; then
    echo "No files found."
    exit 1
fi

cd converted
mogrify -format "$DEST_EXT" *.$SRC_EXT
rm *.$SRC_EXT

echo "Conversion complete. Files are in 'converted/' folder."
