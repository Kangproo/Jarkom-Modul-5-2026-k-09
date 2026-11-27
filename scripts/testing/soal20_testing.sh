#!/bin/bash
# Jalankan pada node sesuai hostname. Tidak mengubah konfigurasi.
case "$(hostname | tr '[:upper:]' '[:lower:]')" in
    gendo|gendou|fuyutsuki|shigeru)
        for t in filter nat routes; do
            diff -u "/tmp/${t}_1" "/tmp/${t}_2" || exit 1
            diff -u "/tmp/${t}_before" "/tmp/${t}_2" || exit 1
        done
        echo "PASS: restore identik dan konfigurasi awal kembali"
        echo "Filter: $(iptables -S | wc -l)"
        echo "NAT: $(iptables -t nat -S | wc -l)"
        echo "Route: $(ip route | wc -l)"
        ;;
    zeruel)
        ping -c 3 -W 1 8.8.8.8
        ping -c 3 -W 1 10.68.4.74
        nc -nvz -w 3 8.8.8.8 53
        ;;
    lilith)
        ping -c 3 -W 1 8.8.8.8
        ping -c 3 -W 1 10.68.4.82
        nc -nvz -w 3 10.68.4.82 9000
        # Ping dan TCP ke Zeruel diharapkan gagal.
        ;;
    *) echo "Node tidak sesuai"; exit 1 ;;
esac
