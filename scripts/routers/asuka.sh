#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.68.4.153
ip route replace 10.68.3.128/26 via 10.68.4.130
ip route replace 10.68.4.48/29 via 10.68.4.134
