#!/bin/bash

# File Permission Audit
# Finds files that are world-writable or have SUID bits set.

echo "File Permission Security Audit"
echo "------------------------------"

SEARCH_DIR=${1:-.}

echo "Searching for world-writable files in '$SEARCH_DIR'..."
find "$SEARCH_DIR" -type f -perm -0002 -ls 2>/dev/null | head -n 10

echo ""
echo "Searching for SUID files in '$SEARCH_DIR' (potential privilege escalation)..."
find "$SEARCH_DIR" -type f -perm -4000 -ls 2>/dev/null | head -n 10

echo ""
echo "------------------------------"
echo "Note: Output limited to first 10 results per category."
