#!/bin/bash
# Bersihkan sisa sabotase Soal 9 jika ada
ip rule del iif eth1 lookup 100 priority 90 2>/dev/null || true
ip route flush table 100 2>/dev/null || true
ip route del blackhole 10.68.4.72/29 2>/dev/null || true
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.68.4.165
ip route replace 10.68.4.88/29 via 10.68.4.146
