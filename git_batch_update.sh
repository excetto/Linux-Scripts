#!/bin/bash

# Git Batch Update
# Iterates through all subdirectories and runs 'git pull' on git repositories.

ROOT_DIR=${1:-$(pwd)}

echo "Scanning for Git repositories in '$ROOT_DIR'..."
echo "------------------------------------------------"

find "$ROOT_DIR" -maxdepth 1 -mindepth 1 -type d | while read -r DIR; do
    if [ -d "$DIR/.git" ]; then
        echo "Updating $(basename "$DIR")..."
        (cd "$DIR" && git pull)
        echo "------------------------------------------------"
    fi
done

echo "Batch update completed."
