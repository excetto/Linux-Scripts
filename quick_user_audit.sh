#!/bin/bash

# Quick User Audit
# Provides a quick overview of logged-in users, recent logins, and sudo-capable accounts.

echo "Logged in users:"
echo "----------------"
who

echo ""
echo "Recent login history (last 10):"
echo "-------------------------------"
if command -v last >/dev/null 2>&1; then
    last -n 10
else
    echo "The 'last' command is not available on this system."
fi

echo ""
echo "Users in sudo or wheel group:"
echo "-----------------------------"
if getent group sudo >/dev/null 2>&1; then
    getent group sudo
fi
if getent group wheel >/dev/null 2>&1; then
    getent group wheel
fi

echo ""
echo "User audit completed."


