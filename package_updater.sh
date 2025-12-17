#!/bin/bash

# Package Updater
# Detects the package manager and updates the system packages.

echo "System Package Updater"
echo "----------------------"

if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (sudo)."
    exit 1
fi

if command -v apt-get &> /dev/null; then
    echo "Debian/Ubuntu detected. Updating..."
    apt-get update && apt-get upgrade -y
elif command -v dnf &> /dev/null; then
    echo "Fedora/RHEL detected. Updating..."
    dnf upgrade -y
elif command -v yum &> /dev/null; then
    echo "CentOS/RHEL detected. Updating..."
    yum update -y
elif command -v pacman &> /dev/null; then
    echo "Arch Linux detected. Updating..."
    pacman -Syu --noconfirm
else
    echo "No supported package manager found."
    exit 1
fi

echo "Update process completed."
