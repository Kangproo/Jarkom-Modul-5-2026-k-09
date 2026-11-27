#!/bin/bash
set -e

iptables -N ZONE_PROTECT 2>/dev/null || true
iptables -F ZONE_PROTECT

iptables -A ZONE_PROTECT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A ZONE_PROTECT -s 10.68.4.56/29 -p icmp --icmp-type echo-request -j ACCEPT

iptables -A ZONE_PROTECT -j DROP

iptables -C FORWARD -i eth0 -d 10.68.4.80/28 -j ZONE_PROTECT 2>/dev/null || iptables -I FORWARD 1 -i eth0 -d 10.68.4.80/28 -j ZONE_PROTECT
