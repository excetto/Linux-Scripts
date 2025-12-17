#!/bin/bash

# Network Speed Test
# Tests download and upload speeds using speedtest-cli

# Check if speedtest-cli is installed
if ! command -v speedtest-cli &> /dev/null; then
    echo "speedtest-cli is not installed. Installing..."
    sudo apt-get install -y speedtest-cli
fi

echo "Running network speed test..."
echo "--------------------------------"

# Run speed test
speedtest-cli --simple

echo "--------------------------------"
echo "Speed test completed"
