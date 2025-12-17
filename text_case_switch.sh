#!/bin/bash

# Text Case Switcher
# Converts the contents of a text file to Uppercase or Lowercase.

if [ $# -lt 2 ]; then
    echo "Usage: $0 <upper|lower> <filename>"
    exit 1
fi

MODE=$1
FILE=$2

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

if [ "$MODE" == "upper" ]; then
    tr '[:lower:]' '[:upper:]' < "$FILE"
elif [ "$MODE" == "lower" ]; then
    tr '[:upper:]' '[:lower:]' < "$FILE"
else
    echo "Error: Mode must be 'upper' or 'lower'."
    exit 1
fi
