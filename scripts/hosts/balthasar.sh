#!/bin/bash
set -e
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update && apt-get install -y iptables netcat-traditional
update-alternatives --set nc /bin/nc.traditional 2>/dev/null || true
pkill -f "nc.traditional -l -p 500" 2>/dev/null || true
nohup sh -c 'while true; do nc.traditional -l -p 5000 >> /tmp/magi_5000.log; done' >/dev/null 2>&1 &
nohup sh -c 'while true; do nc.traditional -l -p 5001 >> /tmp/magi_5001.log; done' >/dev/null 2>&1 &
