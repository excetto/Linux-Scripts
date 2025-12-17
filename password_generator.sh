#!/bin/bash

# Password Generator
# Generates a random secure password of specified length.

LENGTH=${1:-16}

echo "Generating random password (Length: $LENGTH)..."
echo "---------------------------------------------"

# Use openssl if available, otherwise fall back to /dev/urandom
if command -v openssl &> /dev/null; then
    openssl rand -base64 48 | cut -c1-$LENGTH
else
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${LENGTH}
fi

echo ""
echo "---------------------------------------------"
