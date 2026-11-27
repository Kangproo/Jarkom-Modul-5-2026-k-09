#!/bin/bash
# Run the phases in order on the indicated nodes.
case "${1:-}" in
  fast) # Lilith
    ping -i 0.1 -c 50 10.68.4.106 ;;
  counter) # Tokyo3-Core
    iptables -L ICMP_LIMIT -n -v ;;
  normal) # Lilith
    sleep 3
    ping -c 5 -W 1 10.68.4.106 ;;
  final) # Tokyo3-Core
    ping -c 3 -W 1 10.68.4.74
    ping -c 3 -W 1 8.8.8.8
    iptables -S
    ss -lnt ;;
  *) echo 'Usage: bash soal15_testing.sh {fast|counter|normal|final}'; exit 1 ;;
esac
