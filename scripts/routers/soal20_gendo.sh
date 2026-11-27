#!/bin/bash
set -e

sysctl -w net.ipv4.ip_forward=1

if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

# Soal 3: Static Routing + CIDR Summarization
ip route replace 10.68.0.0/23 via 10.68.4.110
ip route replace 10.68.3.0/25 via 10.68.4.110
ip route replace 10.68.4.0/27 via 10.68.4.110
ip route replace 10.68.4.32/28 via 10.68.4.110
ip route replace 10.68.4.112/29 via 10.68.4.110
ip route replace 10.68.4.120/30 via 10.68.4.110

ip route replace 10.68.2.0/24 via 10.68.4.150
ip route replace 10.68.3.224/27 via 10.68.4.150
ip route replace 10.68.4.124/30 via 10.68.4.150

ip route replace 10.68.3.128/26 via 10.68.4.154
ip route replace 10.68.4.48/29 via 10.68.4.154
ip route replace 10.68.4.96/30 via 10.68.4.154
ip route replace 10.68.4.128/29 via 10.68.4.154

ip route replace 10.68.4.100/30 via 10.68.4.158
ip route replace 10.68.4.64/29 via 10.68.4.162

ip route replace 10.68.4.80/28 via 10.68.4.166
ip route replace 10.68.4.144/30 via 10.68.4.166

ip route replace 10.68.3.192/27 via 10.68.4.170
ip route replace 10.68.4.56/29 via 10.68.4.170
ip route replace 10.68.4.72/29 via 10.68.4.170
ip route replace 10.68.4.136/29 via 10.68.4.170

# Reset rules
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Soal 4: NAT (hanya prefix internal keluar lewat NAT1 / eth0)
iptables -t nat -A POSTROUTING -s 10.68.0.0/16 -o eth0 -j MASQUERADE

# Soal 5: Firewall Gendou
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.68.0.0/16 -o eth0 -j ACCEPT
iptables -A FORWARD ! -i eth0 ! -o eth0 -s 10.68.0.0/16 -d 10.68.0.0/16 -j ACCEPT
iptables -A INPUT ! -i eth0 -s 10.68.0.0/16 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
