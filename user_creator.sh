#!/bin/bash

# User Account Creator
# Interactively creates a new system user with a home directory and shell.

echo "New User Wizard"
echo "---------------"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

read -p "Enter username: " USERNAME

if id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' already exists."
    exit 1
fi

read -p "Enter full name (comment): " COMMENT
read -s -p "Enter password: " PASSWORD
echo ""

useradd -m -c "$COMMENT" -s /bin/bash "$USERNAME"

# Set password safely
echo "$USERNAME:$PASSWORD" | chpasswd

if [ $? -eq 0 ]; then
    echo "User '$USERNAME' created successfully."
else
    echo "Failed to create user."
fi
