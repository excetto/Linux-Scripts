#!/bin/bash

# Firewall Blocklist Updater
# Downloads a list of bad IPs (e.g., Emerging Threats) and creates an IPSet blocklist.
# Requires 'ipset' and 'iptables'.

BLOCKLIST_URL="https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt"
IPSET_NAME="blacklist"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

if ! command -v ipset &> /dev/null; then
    echo "Error: 'ipset' is not installed."
    exit 1
fi

echo "Downloading blocklist from $BLOCKLIST_URL..."
TEMP_LIST=$(mktemp)
curl -s "$BLOCKLIST_URL" -o "$TEMP_LIST"

COUNT=$(wc -l < "$TEMP_LIST")
echo "Downloaded $COUNT IPs."

# Create IPSet if not exists
ipset create "$IPSET_NAME" hash:ip hashsize 4096 2>/dev/null

echo "Flushing old set..."
ipset flush "$IPSET_NAME"

echo "Populating set..."
while read -r IP; do
    # Skip comments and empty lines
    [[ "$IP" =~ ^# ]] && continue
    [ -z "$IP" ] && continue
    
    ipset add "$IPSET_NAME" "$IP" -exist
done < "$TEMP_LIST"

rm "$TEMP_LIST"

# Ensure iptables rule exists
if ! iptables -C INPUT -m set --match-set "$IPSET_NAME" src -j DROP 2>/dev/null; then
    echo "Adding iptables rule..."
    iptables -I INPUT -m set --match-set "$IPSET_NAME" src -j DROP
fi

echo "Blocklist updated and active."
