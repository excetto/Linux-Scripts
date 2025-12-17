#!/bin/bash

# SSH Key Setup
# Generates a new SSH key pair and optionally copies it to a remote server.

echo "SSH Key Generation and Setup"
echo "----------------------------"

KEY_NAME="id_rsa_custom"
read -p "Enter key name (default: id_rsa_custom): " INPUT_NAME
KEY_NAME=${INPUT_NAME:-$KEY_NAME}

if [ -f ~/.ssh/$KEY_NAME ]; then
    echo "Error: Key '$KEY_NAME' already exists."
    exit 1
fi

echo "Generating key pair..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/$KEY_NAME

echo ""
read -p "Do you want to copy this key to a remote server? (y/n): " COPY_CONFIRM

if [[ $COPY_CONFIRM =~ ^[Yy]$ ]]; then
    read -p "Enter remote user@host: " REMOTE_HOST
    ssh-copy-id -i ~/.ssh/$KEY_NAME.pub "$REMOTE_HOST"
fi

echo "Setup completed."
