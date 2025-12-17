#!/bin/bash

# PDF Text Extractor
# Extracts text from a PDF file using python (pypdf or simple fallback) or pdftotext.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <pdf_file>"
    exit 1
fi

FILE=$1
OUT_FILE="${FILE%.*}.txt"

if command -v pdftotext &> /dev/null; then
    pdftotext "$FILE" "$OUT_FILE"
    echo "Extracted text to '$OUT_FILE' using pdftotext."
elif command -v python3 &> /dev/null; then
    # Fallback to simple strings extraction if no libs
    echo "pdftotext not found. Using basic string extraction (low quality)..."
    strings "$FILE" > "$OUT_FILE"
    echo "Extracted raw strings to '$OUT_FILE'."
else
    echo "Error: Neither 'pdftotext' nor 'python3' found."
    exit 1
fi
