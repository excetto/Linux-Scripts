#!/bin/bash

# DNS Lookup Tool
# Performs DNS lookups for domain names

# Check if domain argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain_name>"
    echo "Example: $0 google.com"
    exit 1
fi

DOMAIN=$1

echo "DNS Lookup for $DOMAIN"
echo "----------------------"

# Perform DNS lookup
echo "A Records:"
dig +short A $DOMAIN | while read ip; do
    echo "  $ip"
done

echo ""
echo "MX Records:"
dig +short MX $DOMAIN | while read mx; do
    echo "  $mx"
done

echo ""
echo "NS Records:"
dig +short NS $DOMAIN | while read ns; do
    echo "  $ns"
done

echo "----------------------"
echo "DNS lookup completed"
