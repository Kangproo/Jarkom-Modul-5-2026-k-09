#!/bin/bash
# Run on each indicated node, after applying soal16.sh on Tokyo3-Core.
case "${1:-$(hostname)}" in
  Dummy-Plug)
    for port in 22 23 3306 80 8080; do
      nc -vz -w 3 10.68.4.106 "$port"
    done
    ;;
  Lilith)
    nc -vz -w 3 10.68.4.106 80
    nc -vz -w 3 10.68.4.106 8080
    ping -c 3 -W 1 10.68.4.106
    ;;
  Tokyo3-Core)
    iptables -L SCAN_NERV -n -v
    iptables -S
    ss -lnt
    ;;
  *) echo 'Usage: bash soal16_testing.sh {Dummy-Plug|Lilith|Tokyo3-Core}'; exit 1 ;;
esac
