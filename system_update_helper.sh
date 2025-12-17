#!/bin/bash

# System Update Helper
# Detects the system's package manager and runs a safe update/upgrade sequence.

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (e.g. using sudo)."
    exit 1
fi

run_cmd() {
    echo "+ $*"
    "$@"
}

if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    run_cmd apt-get update
    run_cmd apt-get upgrade -y
elif command -v dnf >/dev/null 2>&1; then
    # Fedora/RHEL (newer)
    run_cmd dnf upgrade -y
elif command -v yum >/dev/null 2>&1; then
    # RHEL/CentOS (older)
    run_cmd yum update -y
elif command -v pacman >/dev/null 2>&1; then
    # Arch
    run_cmd pacman -Syu --noconfirm
else
    echo "Unsupported or unknown package manager. Please update your system manually."
    exit 1
fi

echo "System update completed."


