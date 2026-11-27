#!/bin/bash
set -e

iptables -P INPUT DROP

while iptables -C INPUT -p icmp -j DROP 2>/dev/null; do
    iptables -D INPUT -p icmp -j DROP
done

while iptables -C OUTPUT -p udp --dport 53 -j DROP 2>/dev/null; do
    iptables -D OUTPUT -p udp --dport 53 -j DROP
done

iptables -C INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || iptables -I INPUT 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -C INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || iptables -I INPUT 1 -p icmp --icmp-type echo-request -j DROP

iptables -C INPUT -s 10.68.4.68 -p tcp --dport 5000 -j ACCEPT 2>/dev/null || iptables -A INPUT -s 10.68.4.68 -p tcp --dport 5000 -j ACCEPT
