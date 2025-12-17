#!/bin/bash

# Memory Hog Finder
# Identifies top processes consuming the most RAM.

echo "Top Memory Consuming Processes"
echo "------------------------------"

# Header
printf "% -10s % -10s % -10s %s\n" "PID" "%MEM" "RSS" "COMMAND"

# List top 10 memory hogs
ps -eo pid,pmem,rss,comm --sort=-pmem | head -n 11 | tail -n 10 | while read -r PID MEM RSS COMM; do
    # Convert RSS to MB
    RSS_MB=$(awk "BEGIN {printf \"%.2f\", $RSS/1024}")
    printf "% -10s % -10s % -10sMB %s\n" "$PID" "$MEM" "$RSS_MB" "$COMM"
done

echo ""
echo "Total Memory Usage:"
free -h | grep "Mem:"
