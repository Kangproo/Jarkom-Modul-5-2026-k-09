#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.68.4.149
ip route replace 10.68.3.224/27 via 10.68.4.126
