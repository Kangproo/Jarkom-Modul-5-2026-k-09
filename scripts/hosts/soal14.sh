#!/bin/bash
set -e

PILOT_START="${PILOT_START:-01:00:00}"
PILOT_STOP="${PILOT_STOP:-09:00:00}"
PILOT_DAYS="${PILOT_DAYS:-Mon,Tue,Wed,Thu,Fri}"
STAF_START="${STAF_START:-10:00:00}"
STAF_STOP="${STAF_STOP:-16:00:00}"

iptables -N PENPEN_TIME 2>/dev/null || true
iptables -F PENPEN_TIME

for IP in 10.68.4.66 10.68.4.67 10.68.4.68 10.68.3.130; do
    iptables -A PENPEN_TIME -s "$IP" -m time --timestart "$PILOT_START" --timestop "$PILOT_STOP" --weekdays "$PILOT_DAYS" -j ACCEPT
    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

for IP in 10.68.4.74 10.68.4.75; do
    iptables -A PENPEN_TIME -s "$IP" -m time --timestart "$STAF_START" --timestop "$STAF_STOP" -j ACCEPT
    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

for IP in 10.68.4.50 10.68.4.51 10.68.4.102; do
    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

iptables -A PENPEN_TIME -j RETURN

iptables -C INPUT -p icmp --icmp-type echo-request -j PENPEN_TIME 2>/dev/null || iptables -I INPUT 1 -p icmp --icmp-type echo-request -j PENPEN_TIME

iptables -C INPUT -p tcp --dport 80 -j PENPEN_TIME 2>/dev/null || iptables -I INPUT 1 -p tcp --dport 80 -j PENPEN_TIME
