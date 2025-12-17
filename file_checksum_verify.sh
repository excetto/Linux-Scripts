#!/bin/bash

# File Checksum Verifier
# Generates a SHA256 checksum for a file or verifies it against a provided hash.

if [ $# -lt 1 ]; then
    echo "Usage 1: $0 <filename> (Generate hash)"
    echo "Usage 2: $0 <filename> <expected_hash> (Verify hash)"
    exit 1
fi

FILE=$1
EXPECTED=$2

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

HASH=$(sha256sum "$FILE" | awk '{print $1}')

if [ -z "$EXPECTED" ]; then
    echo "SHA256 Hash: $HASH"
else
    if [ "$HASH" == "$EXPECTED" ]; then
        echo "✅ Checksum MATCHES."
    else
        echo "❌ Checksum MISMATCH."
        echo "Computed: $HASH"
        echo "Expected: $EXPECTED"
    fi
fi
