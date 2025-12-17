#!/bin/bash

# File Encryption (GPG)
# Encrypts a file using symmetric GPG encryption (password based).

if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE=$1

if ! command -v gpg &> /dev/null; then
    echo "Error: gpg is not installed."
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

echo "Encrypting '$FILE'..."
gpg -c "$FILE"

if [ -f "$FILE.gpg" ]; then
    echo "Success: '$FILE.gpg' created."
    echo "To decrypt, run: gpg '$FILE.gpg'"
else
    echo "Encryption failed."
fi
