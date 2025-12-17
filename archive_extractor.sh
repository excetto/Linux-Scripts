#!/bin/bash

# Archive Extractor
# Extracts various archive formats based on file extension.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <archive_file>"
    exit 1
fi

ARCHIVE=$1

if [ ! -f "$ARCHIVE" ]; then
    echo "Error: File '$ARCHIVE' not found."
    exit 1
fi

echo "Extracting '$ARCHIVE'..."

check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: Command '$1' is required but not installed."
        exit 1
    fi
}

case $ARCHIVE in
    *.tar.bz2)   tar xjf "$ARCHIVE"    ;;
    *.tar.gz)    tar xzf "$ARCHIVE"    ;;
    *.bz2)       bunzip2 "$ARCHIVE"    ;;
    *.rar)       check_cmd unrar; unrar x "$ARCHIVE"    ;;
    *.gz)        gunzip "$ARCHIVE"     ;;
    *.tar)       tar xf "$ARCHIVE"     ;;
    *.tbz2)      tar xjf "$ARCHIVE"    ;;
    *.tgz)       tar xzf "$ARCHIVE"    ;;
    *.zip)       check_cmd unzip; unzip "$ARCHIVE"      ;;
    *.Z)         uncompress "$ARCHIVE" ;;
    *.7z)        check_cmd 7z; 7z x "$ARCHIVE"       ;;
    *)           echo "Unknown archive format" ;;
esac

echo "Extraction finished."
