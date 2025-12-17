#!/bin/bash

# S3 Bucket Sync (AWS/MinIO Wrapper)
# Syncs a local directory to an S3 bucket with dry-run capability.

SRC_DIR=$1
BUCKET_URI=$2 # e.g., s3://my-bucket/backups
PROFILE=${3:-default} # AWS CLI profile

if [ -z "$BUCKET_URI" ]; then
    echo "Usage: $0 <local_dir> <s3_uri> [aws_profile]"
    exit 1
fi

if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed."
    exit 1
fi

echo "Syncing '$SRC_DIR' -> '$BUCKET_URI' (Profile: $PROFILE)"

# Dry Run first
echo "--- DRY RUN PREVIEW ---"
aws s3 sync "$SRC_DIR" "$BUCKET_URI" --profile "$PROFILE" --dryrun

echo "-----------------------"
read -p "Proceed with actual sync? (y/n): " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    aws s3 sync "$SRC_DIR" "$BUCKET_URI" --profile "$PROFILE" --delete
    if [ $? -eq 0 ]; then
        echo "Sync completed."
    else
        echo "Sync failed."
    fi
else
    echo "Cancelled."
fi
