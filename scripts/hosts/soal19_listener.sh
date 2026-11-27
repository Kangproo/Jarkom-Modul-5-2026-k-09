#!/bin/bash
# Setup listener pengujian; dijalankan sebelum isolasi pada Armisael.
set -e
case "$(hostname | tr '[:upper:]' '[:lower:]')" in
    armisael) log=/tmp/soal19_armisael.log ;;
    zeruel) log=/tmp/soal17_zeruel.log ;;
    lilith) log=/tmp/soal19_lilith.log ;;
    *) echo 'Node tidak sesuai'; exit 1 ;;
esac
command -v nc.traditional >/dev/null || { echo 'Install netcat-traditional terlebih dahulu'; exit 1; }
if ! ss -lntH 'sport = :9000' | grep -q .; then
    nohup sh -c 'while true; do nc.traditional -l -p 9000 >> "$1" || sleep 1; done' sh "$log" </dev/null >"${log}.err" 2>&1 &
    sleep 2
fi
ss -lnt
