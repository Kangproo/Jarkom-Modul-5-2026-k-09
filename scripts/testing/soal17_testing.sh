#!/bin/bash
# Jalankan bagian sesuai node. Listener TCP 9000 harus sudah aktif.
case "${1:-}" in
  casper)
    ping -c 3 -W 1 10.68.4.82
    echo 'PESAN-CASPER-UNTUK-ZERUEL' | nc.traditional -nv -w 3 -q 1 10.68.4.82 9000
    ;;
  fuyutsuki)
    conntrack -L -p tcp --orig-src 10.68.4.58 --orig-dst 10.68.4.82
    iptables -t nat -L PREROUTING -n -v
    ;;
  penpen)
    hostname
    cat /tmp/soal17_penpen.log
    ss -lnt
    ;;
  zeruel)
    hostname
    wc -c /tmp/soal17_zeruel.log
    cat /tmp/soal17_zeruel.log
    ss -lnt
    ;;
  *) echo 'Usage: bash soal17_testing.sh {casper|fuyutsuki|penpen|zeruel}'; exit 1;;
esac
