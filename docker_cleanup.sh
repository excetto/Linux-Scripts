#!/bin/bash

# Docker Cleanup
# Removes unused Docker containers, networks, images, and build cache.

echo "Docker System Cleanup"
echo "---------------------"

if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    exit 1
fi

echo "This will remove:"
echo "- All stopped containers"
echo "- All networks not used by at least one container"
echo "- All dangling images"
echo "- All dangling build cache"

read -p "Are you sure you want to proceed? (y/n): " CONFIRM

if [[ $CONFIRM =~ ^[Yy]$ ]]; then
    docker system prune -f
    echo "Cleanup completed."
else
    echo "Operation cancelled."
fi
