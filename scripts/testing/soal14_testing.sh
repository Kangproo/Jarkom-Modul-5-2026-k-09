#!/bin/bash
# Run on Pen-Pen: bash soal14_testing.sh A|B|counter|restore
# Run on Unit-01, Lilith, Spy: bash soal14_testing.sh client
# A/B reproduce the temporary test schedules on Nov 27, 2026, 16:28-16:57 UTC.
# A expects Unit-01 DROP, Lilith ACCEPT, Spy DROP.
# B expects Unit-01 ACCEPT, Lilith DROP, Spy DROP.
# Check date -u first; if the test time changes, adjust the temporary windows.
# Restore the original schedule after testing.
case "${1:-}" in
    A)
        STAF_START=00:00:00 STAF_STOP=23:59:59 bash /root/soal14.sh && date -u && iptables -L PENPEN_TIME -n -v
        ;;
    B)
        PILOT_START=00:00:00 PILOT_STOP=23:59:59 PILOT_DAYS=Mon,Tue,Wed,Thu,Fri,Sat,Sun STAF_START=01:00:00 STAF_STOP=02:00:00 bash /root/soal14.sh && date -u && iptables -L PENPEN_TIME -n -v
        ;;
    client)
        date -u
        ping -c 3 -W 1 10.68.3.194
        nc -vz -w 3 10.68.3.194 80
        ;;
    counter)
        date -u
        iptables -L PENPEN_TIME -n -v
        ;;
    restore)
        bash /root/soal14.sh && iptables-save > /root/soal14.rules && iptables -S
        ;;
    *) echo 'Usage: soal14_testing.sh A|B|client|counter|restore'; exit 1 ;;
esac
