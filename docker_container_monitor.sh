#!/bin/bash

# Docker Container Monitor
# Displays CPU and Memory usage for running containers, including limits.

if ! command -v docker &> /dev/null;
    echo "Error: Docker not installed."
    exit 1
fi

echo "Docker Container Resource Usage"
echo "-------------------------------"

# Format: Name, CPU %, Mem Usage, Mem Limit, Mem %
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"
