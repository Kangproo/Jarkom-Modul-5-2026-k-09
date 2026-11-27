#!/bin/bash
set -e

iptables -N BALTHASAR_ACCESS 2>/dev/null || true
iptables -F BALTHASAR_ACCESS

iptables -A BALTHASAR_ACCESS -s 10.68.4.58 -j ACCEPT
iptables -A BALTHASAR_ACCESS -s 10.68.4.66 -j ACCEPT
iptables -A BALTHASAR_ACCESS -s 10.68.4.67 -j ACCEPT
iptables -A BALTHASAR_ACCESS -s 10.68.4.68 -j ACCEPT
iptables -A BALTHASAR_ACCESS -s 10.68.3.130 -j ACCEPT
iptables -A BALTHASAR_ACCESS -p tcp -j REJECT --reject-with tcp-reset

iptables -C INPUT -p tcp -m multiport --dports 5000,5001 -j BALTHASAR_ACCESS 2>/dev/null || iptables -I INPUT 1 -p tcp -m multiport --dports 5000,5001 -j BALTHASAR_ACCESS
