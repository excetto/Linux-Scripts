#!/bin/bash

# Disk Usage Report
# Shows the largest directories under a given path to help identify where disk space is used.

TARGET_DIR="${1:-.}"
TOP_N="${2:-10}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a directory."
    echo "Usage: $0 [directory] [top_n]"
    echo "Example: $0 /var 15"
    exit 1
fi

echo "Disk usage report for: $TARGET_DIR"
echo "Showing top $TOP_N entries by size"
echo "----------------------------------------"

du -h --max-depth=1 "$TARGET_DIR" 2>/dev/null | sort -hr | head -n "$TOP_N"

echo "----------------------------------------"
echo "Tip: Pass a different directory and count, e.g. '$0 /home 20'"

*** Add File: Linux-Scripts/log_quick_view.sh
#!/bin/bash

# Log Quick View
# Displays the last N lines from common system logs for quick troubleshooting.

LINES="${1:-50}"

echo "Showing last $LINES lines from common logs (if present)..."
echo "-----------------------------------------------------------"

LOG_FILES=(
    "/var/log/syslog"
    "/var/log/messages"
    "/var/log/auth.log"
    "/var/log/secure"
)

for LOG in "${LOG_FILES[@]}"; do
    if [ -f "$LOG" ]; then
        echo ""
        echo "=== $LOG ==="
        tail -n "$LINES" "$LOG"
    fi
done

if command -v journalctl >/dev/null 2>&1; then
    echo ""
    echo "=== journalctl (last $LINES lines) ==="
    journalctl -n "$LINES"
fi

echo ""
echo "Log quick view completed."

*** Add File: Linux-Scripts/process_top_cpu.sh
#!/bin/bash

# Top CPU Processes
# Lists the processes using the most CPU on the system.

COUNT="${1:-10}"

echo "Top $COUNT processes by CPU usage:"
echo "----------------------------------"
ps aux --sort=-%cpu | head -n "$((COUNT + 1))"

*** Add File: Linux-Scripts/process_top_memory.sh
#!/bin/bash

# Top Memory Processes
# Lists the processes using the most memory on the system.

COUNT="${1:-10}"

echo "Top $COUNT processes by memory usage:"
echo "-------------------------------------"
ps aux --sort=-%mem | head -n "$((COUNT + 1))"

*** Add File: Linux-Scripts/find_recent_files.sh
#!/bin/bash

# Find Recent Files
# Lists files modified in the last N minutes under a given directory.

TARGET_DIR="${1:-.}"
MINUTES="${2:-60}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a directory."
    echo "Usage: $0 [directory] [minutes]"
    echo "Example: $0 /var/log 30"
    exit 1
fi

echo "Files in '$TARGET_DIR' modified in the last $MINUTES minutes:"
echo "-------------------------------------------------------------"

find "$TARGET_DIR" -type f -mmin "-$MINUTES" -print 2>/dev/null

*** Add File: Linux-Scripts/backup_directory_tar.sh
#!/bin/bash

# Directory Backup (tar.gz)
# Creates a timestamped tar.gz backup of a directory.

SOURCE_DIR="${1:-.}"
DEST_DIR="${2:-$HOME/backups}"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: '$SOURCE_DIR' is not a directory."
    echo "Usage: $0 [source_dir] [destination_dir]"
    echo "Example: $0 /etc /root/backups"
    exit 1
fi

mkdir -p "$DEST_DIR"

TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
BASENAME="$(basename "$SOURCE_DIR")"
ARCHIVE="$DEST_DIR/${BASENAME}_backup_${TIMESTAMP}.tar.gz"

echo "Creating backup of '$SOURCE_DIR' at '$ARCHIVE'..."
tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE_DIR")" "$BASENAME"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
    echo "File: $ARCHIVE"
else
    echo "Backup failed."
fi

*** Add File: Linux-Scripts/service_status_overview.sh
#!/bin/bash

# Service Status Overview
# Shows the status of failed and running systemd services.

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Error: systemctl is not available. This script requires systemd."
    exit 1
fi

echo "Failed services:"
echo "----------------"
systemctl --failed || echo "No failed services."

echo ""
echo "Running services (top 20):"
echo "--------------------------"
systemctl list-units --type=service --state=running | head -n 23

*** Add File: Linux-Scripts/temp_cleanup_preview.sh
#!/bin/bash

# Temporary Files Cleanup (Preview)
# Shows files in /tmp older than N days and optionally deletes them.

DAYS="${1:-7}"
ACTION="${2:-preview}"  # preview or delete

echo "Looking for files in /tmp older than $DAYS days..."
echo "Mode: $ACTION"
echo "------------------------------------------"

find /tmp -type f -mtime "+$DAYS" -print 2>/dev/null | sed 's/^/FOUND: /'

if [ "$ACTION" = "delete" ]; then
    echo ""
    echo "Deleting files..."
    find /tmp -type f -mtime "+$DAYS" -delete 2>/dev/null
    echo "Cleanup completed."
else
    echo ""
    echo "Preview mode only. To delete files, run:"
    echo "$0 $DAYS delete"
fi

*** Add File: Linux-Scripts/system_update_helper.sh
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

*** Add File: Linux-Scripts/quick_user_audit.sh
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


