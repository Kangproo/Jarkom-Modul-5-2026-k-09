#!/bin/bash
# Commands used in the lab. Run the relevant case on each node.
case "${1:-}" in
  casper)
    date -u
    ping -c 3 -W 1 8.8.8.8
    getent hosts deb.debian.org
    apt-get update
    echo "APT exit code: $?"
    iptables -S
    iptables -L -n -v
    ss -lnt
    ;;
  unit00|balthasar)
    nc -nvz -w 3 10.68.4.58 5000
    ping -c 3 -W 1 10.68.4.58
    ;;
  *) echo 'Usage: bash soal12_testing.sh casper|unit00|balthasar'; exit 1 ;;
esac
