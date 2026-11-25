#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.68.4.161
# Pastikan tidak ada rule NAT/SNAT (Soal 10)
command -v iptables >/dev/null 2>&1 && iptables -t nat -F || true
