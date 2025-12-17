#!/bin/bash

# User Login History
# Displays the last login time for all users who have a login shell.

echo "User Login History"
echo "------------------"

# Get users with valid shells (usually /bin/bash or /bin/sh)
grep -E "(/bin/bash|/bin/sh|/bin/zsh)" /etc/passwd | cut -d: -f1 | while read -r USER; do
    LAST_LOGIN=$(last -n 1 "$USER" | head -n 1)
    if [ -n "$LAST_LOGIN" ]; then
        echo "$LAST_LOGIN"
    else
        echo "$USER: Never logged in"
    fi
done
