#!/bin/bash
# Jalankan pada node yang sesuai: Unit-01, Lilith, Magi-Melchior, Magi-Balthasar.
case "$(hostname)" in
  Unit-01|Lilith|Magi-Melchior)
    # Unit-01: succeeded; Lilith dan Magi-Melchior: Connection refused.
    nc -vz -w 3 10.68.4.59 5000
    nc -vz -w 3 10.68.4.59 5001
    ;;
  Magi-Balthasar)
    iptables -L BALTHASAR_ACCESS -n -v
    ping -c 3 -W 1 8.8.8.8
    ss -lnt
    ;;
  *) echo 'Jalankan pada node pengujian yang sesuai.'; exit 1 ;;
esac
