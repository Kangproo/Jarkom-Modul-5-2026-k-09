#!/bin/bash
# Run on each designated node, passing its role as argument.
case "${1:-}" in
  zeruel|radar)
    ping -c 3 -W 1 10.68.4.74
    ping -c 3 -W 1 8.8.8.8
    ;;
  casper)
    ping -c 3 -W 1 10.68.4.82
    ;;
  lilith)
    ping -c 3 -W 1 10.68.4.82
    nc -vz -w 3 10.68.4.82 9000
    ;;
  shigeru)
    iptables -L ZONE_PROTECT -n -v
    iptables -S
    ;;
  *) echo 'Usage: bash soal18_testing.sh {zeruel|radar|casper|lilith|shigeru}'; exit 2 ;;
esac
