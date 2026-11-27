#!/bin/bash
# Rekonstruksi command pengujian yang telah dilakukan di GNS3.
# Jalankan sesuai node; baseline dan isolasi Armisael memakai command sama.
# Jangan gunakan set -e: kegagalan ping/nc setelah isolasi memang diharapkan.
case "$(hostname | tr '[:upper:]' '[:lower:]')" in
    armisael)
        ping -c 3 -W 1 10.68.4.81
        ping -c 3 -W 1 10.68.4.82
        ping -c 3 -W 1 10.68.4.74
        ping -c 3 -W 1 8.8.8.8
        nc -nvz -w 3 10.68.4.82 9000
        nc -nvz -w 3 10.68.4.74 9000
        nc -nvz -w 3 8.8.8.8 53
        ;;
    zeruel)
        ping -c 3 -W 1 10.68.4.83
        nc -nvz -w 3 10.68.4.83 9000
        ping -c 3 -W 1 10.68.4.74
        ping -c 3 -W 1 8.8.8.8
        nc -nvz -w 3 10.68.4.74 9000
        nc -nvz -w 3 8.8.8.8 53
        ;;
    *) echo 'Jalankan di Armisael atau Zeruel'; exit 1 ;;
esac
