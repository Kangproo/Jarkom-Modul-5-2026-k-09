#!/bin/bash
set -e
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update && apt-get install -y iptables netcat-traditional
update-alternatives --set nc /bin/nc.traditional 2>/dev/null || true
pkill -f "nc.traditional -l -p 80" 2>/dev/null || true
nohup sh -c 'while true; do echo "Welcome to $(hostname)" | nc.traditional -l -p 80 -q 0; done' >/dev/null 2>&1 &
