#!/bin/bash

# RAM Cache Cleaner
# Clears the PageCache, dentries, and inodes. Useful for benchmarking or freeing up 'buff/cache'.

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

echo "Current Memory Usage:"
free -h
echo "---------------------"

echo "1. Clear PageCache only"
echo "2. Clear dentries and inodes"
echo "3. Clear PageCache, dentries, and inodes"
read -p "Select option (1-3): " OPT

case $OPT in
    1) echo 1 > /proc/sys/vm/drop_caches ;;
    2) echo 2 > /proc/sys/vm/drop_caches ;;
    3) echo 3 > /proc/sys/vm/drop_caches ;;
    *) echo "Invalid option"; exit 1 ;;
esac

echo "Cache cleared."
echo "---------------------"
free -h
