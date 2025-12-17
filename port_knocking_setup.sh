#!/bin/bash

# Port Knocking Setup Generator
# Generates a shell script with the specific iptables commands needed to enable port knocking.
# Default sequence: 7000 -> 8000 -> 9000 to open Port 22 (SSH).

echo "Port Knocking Configuration Generator"
echo "-------------------------------------"

KNOCK_1=7000
KNOCK_2=8000
KNOCK_3=9000
TARGET_PORT=22

OUTPUT_SCRIPT="apply_port_knocking.sh"

cat <<EOF > "$OUTPUT_SCRIPT"
#!/bin/bash
# Generated Port Knocking Rules
# Sequence: $KNOCK_1 -> $KNOCK_2 -> $KNOCK_3 -> Open Port $TARGET_PORT for 30 seconds

iptables -N KNOCKING
iptables -A INPUT -j KNOCKING

# 1. Check if user has passed the final gate (Stage 3)
iptables -A KNOCKING -m recent --name STAGE3 --rcheck --seconds 30 -p tcp --dport $TARGET_PORT -j ACCEPT

# 2. Knock 3 (Moves Stage 2 -> Stage 3)
iptables -A KNOCKING -m recent --name STAGE2 --remove
iptables -A KNOCKING -p tcp --dport $KNOCK_3 -m recent --name STAGE3 --set -j DROP

# 3. Knock 2 (Moves Stage 1 -> Stage 2)
iptables -A KNOCKING -m recent --name STAGE1 --remove
iptables -A KNOCKING -p tcp --dport $KNOCK_2 -m recent --name STAGE2 --set -j DROP

# 4. Knock 1 (Starts Stage 1)
iptables -A KNOCKING -p tcp --dport $KNOCK_1 -m recent --name STAGE1 --set -j DROP

echo "Port knocking rules applied."
echo "Use 'hping3' or 'knock' client to trigger."
EOF

chmod +x "$OUTPUT_SCRIPT"
echo "Script '$OUTPUT_SCRIPT' generated."
echo "Review it carefully before running."
