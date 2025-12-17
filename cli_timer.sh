#!/bin/bash

# CLI Countdown Timer
# A simple countdown timer for the terminal.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <seconds>"
    exit 1
fi

SECONDS=$1

echo "Timer started for $SECONDS seconds..."

while [ $SECONDS -gt 0 ]; do
    printf "\rTime remaining: %02d:%02d:%02d" $((SECONDS/3600)) $(( (SECONDS/60)%60 )) $((SECONDS%60))
    sleep 1
    : $((SECONDS--))
done

printf "\rTime's up!                 \n"
# Beep
echo -e "\a"
