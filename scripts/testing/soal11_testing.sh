#!/bin/bash
# Run on each corresponding node. Expected ping results are documented below.
case "$(hostname)" in
  Magi-Balthasar|Lilith)
    ping -c 3 -W 1 10.68.4.58 # expected: 100% packet loss
    ;;
  Magi-Casper)
    iptables -S
    ping -c 3 10.68.4.59 # expected: 0% packet loss
    ping -c 3 10.68.4.74 # expected: 0% packet loss
    ss -lnt # expected: port 5000 LISTEN
    ;;
  *) echo 'Run on Magi-Casper, Magi-Balthasar, or Lilith.'; exit 1 ;;
esac
