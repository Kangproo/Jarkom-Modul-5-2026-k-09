#!/bin/bash
set -e

case "$(hostname | tr '[:upper:]' '[:lower:]')" in
    gendo|gendou) nama=gendo ;;
    shigeru) nama=shigeru ;;
    fuyutsuki) nama=fuyutsuki ;;
    *) echo "Node tidak sesuai"; exit 1 ;;
esac

test -s "/root/$nama.sh"

iptables -S > /tmp/filter_before
iptables -t nat -S > /tmp/nat_before
iptables-save > "/root/$nama.rules"
test -s "/root/$nama.rules"

ip -4 route show | sort > /tmp/routes_before
ip -4 route show | awk '$2=="via" && $3 ~ /^10\.68\./' > /tmp/routes_manual
test -s /tmp/routes_manual

echo "=== BACKUP $nama ==="
ls -l "/root/$nama.rules"

for table in filter nat mangle raw security; do
    if iptables -t "$table" -S >/dev/null 2>&1; then
        iptables -t "$table" -S | awk '$1=="-P"{print $2}' |
        while read -r chain; do
            iptables -t "$table" -P "$chain" ACCEPT
        done
        iptables -t "$table" -F
        iptables -t "$table" -X
    fi
done

while read -r dst via gw rest; do
    ip -4 route del "$dst" via "$gw"
done < /tmp/routes_manual

echo "=== SETELAH DIHAPUS ==="
iptables -S
iptables -t nat -S
ip route

for i in 1 2; do
    bash "/root/$nama.sh"
    iptables-restore < "/root/$nama.rules"

    echo "=== RESTORE $i ==="
    echo "Filter: $(iptables -S | wc -l)"
    echo "NAT: $(iptables -t nat -S | wc -l)"
    echo "Route: $(ip -4 route show | wc -l)"

    iptables -S > "/tmp/filter_$i"
    iptables -t nat -S > "/tmp/nat_$i"
    ip -4 route show | sort > "/tmp/routes_$i"
done

echo "=== PERBANDINGAN ==="
diff -u /tmp/filter_1 /tmp/filter_2
diff -u /tmp/nat_1 /tmp/nat_2
diff -u /tmp/routes_1 /tmp/routes_2
echo "PASS: RESTORE 1 DAN 2 IDENTIK"

diff -u /tmp/filter_before /tmp/filter_2
diff -u /tmp/nat_before /tmp/nat_2
diff -u /tmp/routes_before /tmp/routes_2
echo "PASS: KONFIGURASI AWAL KEMBALI"
