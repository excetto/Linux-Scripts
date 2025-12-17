#!/bin/bash

# WHOIS Lookup
# Retrieves registration information for a domain.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

if ! command -v whois &> /dev/null; then
    echo "Error: 'whois' is not installed. Please install it first."
    exit 1
fi

echo "Retrieving WHOIS data for $DOMAIN..."
whois "$DOMAIN" | grep -E -i "Domain Name:|Registry Expiry Date:|Registrar:|Creation Date:|Updated Date:" | head -n 20
