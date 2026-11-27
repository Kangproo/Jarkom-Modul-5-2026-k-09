#!/bin/bash
set -e

iptables -N SCAN_NERV 2>/dev/null || true
iptables -F SCAN_NERV

iptables -A SCAN_NERV -j LOG --log-prefix "SCAN-NERV: "
iptables -A SCAN_NERV -p tcp -j REJECT --reject-with tcp-reset

iptables -C INPUT -s 10.68.4.51 -p tcp -m multiport --dports 22,23,3306 -j SCAN_NERV 2>/dev/null || iptables -I INPUT 1 -s 10.68.4.51 -p tcp -m multiport --dports 22,23,3306 -j SCAN_NERV
