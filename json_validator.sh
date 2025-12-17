#!/bin/bash

# JSON Validator & Formatter
# Validates JSON structure and pretty-prints it.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <json_file>"
    exit 1
fi

FILE=$1

if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    exit 1
fi

echo "Validating '$FILE'..."

# Use Python's built-in json.tool
if python3 -m json.tool "$FILE" > /dev/null; then
    echo "✅ Valid JSON."
    echo "Formatted Output:"
    echo "-----------------"
    python3 -m json.tool "$FILE"
else
    echo "❌ Invalid JSON."
fi
