#!/bin/bash

# system_uptime.sh
# This script displays the system uptime, average load, and the number of currently logged-in users.

echo "System Uptime and Load:"
uptime

echo -e "\nCurrently Logged-in Users:"
who | wc -l
