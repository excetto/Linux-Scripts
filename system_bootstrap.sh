#!/bin/bash

# System Bootstrap (Simple Ansible-like)
# Reads a list of packages and ensures they are installed.
# Supports apt, dnf, yum.

PACKAGE_LIST=$1

if [ -z "$PACKAGE_LIST" ]; then
    echo "Usage: $0 <package_list.txt>"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

# Detect Package Manager
if command -v apt-get &> /dev/null; then
    PKG_MGR="apt-get"
    INSTALL_CMD="apt-get install -y"
    CHECK_CMD="dpkg -s"
elif command -v dnf &> /dev/null; then
    PKG_MGR="dnf"
    INSTALL_CMD="dnf install -y"
    CHECK_CMD="rpm -q"
else
    echo "Unsupported package manager."
    exit 1
fi

echo "Bootstrapping system using $PKG_MGR..."
echo "--------------------------------------"

while read -r PKG; do
    [[ "$PKG" =~ ^# ]] && continue
    [ -z "$PKG" ] && continue

    if $CHECK_CMD "$PKG" &> /dev/null; then
        echo "✅ $PKG is already installed."
    else
        echo "⬇️ Installing $PKG..."
        $INSTALL_CMD "$PKG"
        if [ $? -ne 0 ]; then
            echo "❌ Failed to install $PKG"
        fi
    fi
done < "$PACKAGE_LIST"

echo "Bootstrap completed."
