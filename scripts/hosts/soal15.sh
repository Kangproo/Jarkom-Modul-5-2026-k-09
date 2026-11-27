#!/bin/bash
set -e

iptables -N ICMP_LIMIT 2>/dev/null || true
iptables -F ICMP_LIMIT

iptables -A ICMP_LIMIT -m limit --limit 5/second --limit-burst 1 -j ACCEPT
iptables -A ICMP_LIMIT -j DROP

iptables -C INPUT -p icmp --icmp-type echo-request -j ICMP_LIMIT 2>/dev/null || iptables -I INPUT 1 -p icmp --icmp-type echo-request -j ICMP_LIMIT
