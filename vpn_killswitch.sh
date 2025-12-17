#!/bin/bash

# VPN Killswitch (UFW)
# Configures UFW to block all outgoing traffic except through the VPN interface (tun0).

VPN_IFACE="tun0"
LAN_SUBNET="192.168.1.0/24" # Adjust to your local network

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

if ! command -v ufw &> /dev/null; then
    echo "Error: UFW is not installed."
    exit 1
fi

echo "Configuring VPN Killswitch on $VPN_IFACE..."
read -p "This will reset UFW rules. Continue? (y/n): " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    ufw reset
    ufw default deny incoming
    ufw default deny outgoing
    
    # Allow LAN access (optional, usually needed)
    ufw allow out to "$LAN_SUBNET"
    ufw allow in from "$LAN_SUBNET"
    
    # Allow traffic out on VPN interface
    ufw allow out on "$VPN_IFACE"
    ufw allow in on "$VPN_IFACE"
    
    # Allow VPN establishment (UDP 1194 usually, checking typical OpenVPN)
    # Note: You must allow the specific port/IP of your VPN provider here
    # ufw allow out to <VPN_SERVER_IP> port <VPN_PORT> proto udp
    
    echo "Rules updated. Enable with 'ufw enable'."
    echo "IMPORTANT: You MUST whitelist your VPN provider's IP manually to connect!"
else
    echo "Cancelled."
fi
