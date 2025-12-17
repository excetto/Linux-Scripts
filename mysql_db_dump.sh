#!/bin/bash

# MySQL Database Backup
# Creates a gzipped dump of a specified MySQL database.

if [ $# -lt 3 ]; then
    echo "Usage: $0 <db_host> <db_user> <db_name>"
    exit 1
fi

HOST=$1
USER=$2
DB=$3
DATE=$(date +%Y%m%d_%H%M%S)
OUT_FILE="${DB}_backup_${DATE}.sql.gz"

if ! command -v mysqldump &> /dev/null; then
    echo "Error: mysqldump is not installed."
    exit 1
fi

echo "Backing up database '$DB' from '$HOST'..."
read -s -p "Enter MySQL password for '$USER': " PASSWORD
echo ""

mysqldump -h "$HOST" -u "$USER" -p"$PASSWORD" "$DB" | gzip > "$OUT_FILE"

if [ $? -eq 0 ]; then
    echo "Backup saved to '$OUT_FILE'."
else
    echo "Backup failed."
fi
