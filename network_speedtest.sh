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

# Run speed test with alternative servers if main fails
if ! speedtest-cli --simple; then
    echo "Main speedtest failed, trying alternative method..."
    echo "Testing with curl to speedtest.net..."
    curl -s https://www.speedtest.net/ | grep -oP '(?<=url: ")[^"]+' | head -1 | xargs curl -o /dev/null -s -w "Download speed: %{speed_download} bytes/sec\n"
fi

echo "--------------------------------"
echo "Speed test completed"
