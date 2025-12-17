#!/bin/bash

# Database Auto Snapshot
# Backs up all MySQL/MariaDB databases and handles rotation (keeps last 7 days).

BACKUP_DIR="/var/backups/db_snapshots"
MYSQL_USER="root"
# It's safer to use .my.cnf, but for this script we assume passwordless or ~/.my.cnf auth
# If password is needed, consider loading from a secured file.

mkdir -p "$BACKUP_DIR"

if ! command -v mysqldump &> /dev/null; then
    echo "Error: mysqldump not found."
    exit 1
fi

echo "Starting Database Snapshot..."
echo "-----------------------------"

# Get list of databases
DBS=$(mysql -u "$MYSQL_USER" -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|sys)")

for DB in $DBS; do
    DATE=$(date +%F_%H-%M-%S)
    FILE="$BACKUP_DIR/${DB}_${DATE}.sql.gz"
    
    echo "Backing up: $DB -> $FILE"
    mysqldump -u "$MYSQL_USER" --single-transaction --quick --lock-tables=false "$DB" | gzip > "$FILE"
    
    if [ $? -eq 0 ]; then
        echo "✅ Success"
    else
        echo "❌ Failure"
    fi
done

echo "-----------------------------"
echo "Cleaning up snapshots older than 7 days..."
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +7 -print -delete
echo "Cleanup done."
