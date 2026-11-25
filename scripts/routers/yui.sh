#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.68.4.109
ip route replace 10.68.4.32/28 via 10.68.4.114
ip route replace 10.68.0.0/23 via 10.68.4.118
ip route replace 10.68.4.0/27 via 10.68.4.122
