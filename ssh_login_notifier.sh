#!/bin/bash

# SSH Login Notifier
# Sends an email when a successful SSH login occurs.
# Usage: Add "source /path/to/ssh_login_notifier.sh" to /etc/profile or ~/.bashrc

EMAIL_TO="admin@example.com"

if [ -n "$SSH_CONNECTION" ]; then
    CLIENT_IP=$(echo "$SSH_CONNECTION" | awk '{print $1}')
    
    SUBJECT="SSH Login Alert: $USER on $(hostname)"
    BODY="User '$USER' logged in from IP: $CLIENT_IP\nTime: $(date)"
    
    if command -v mail &>/dev/null; then
        echo -e "$BODY" | mail -s "$SUBJECT" "$EMAIL_TO"
    else
        # Fallback logging if mail not configured
        logger -t "SSH_ALERT" "$BODY"
    fi
fi

