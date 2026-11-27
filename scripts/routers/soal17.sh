#!/bin/bash
set -e

iptables -t nat -C PREROUTING -s 10.68.4.58 -d 10.68.4.82 -p tcp -j DNAT --to-destination 10.68.3.194 2>/dev/null || iptables -t nat -A PREROUTING -s 10.68.4.58 -d 10.68.4.82 -p tcp -j DNAT --to-destination 10.68.3.194
