#!/bin/bash

# Límite de conexiones permitidas por IP (puerto 22)
LIMIT=99
INTERVAL=15

while true; do
    echo "[$(date)] Analizando conexiones activas..."

    # Obtener IPs con conexiones activas (puedes cambiarlo por otro puerto si no es SSH)
    target=$(netstat -tapn 2>/dev/null | awk '{print $5}' | grep -E '^[0-9]' | cut -d: -f1 \
             | sort | uniq -c | sed -r 's/^[[:space:]]+//g' | sort -k1 -n -r | head -1)

    number_of_connections=$(echo "$target" | awk '{print $1}')
    ip_target=$(echo "$target" | awk '{print $2}')

    echo "Número de conexiones: $number_of_connections"
    echo "IP objetivo: $ip_target"

    if [ "$number_of_connections" -gt "$LIMIT" ]; then
        echo ">> Se excedió el límite: $ip_target con $number_of_connections conexiones"
        if iptables -C INPUT -s "$ip_target" -j DROP 2>/dev/null; then
            echo ">> La IP ya está bloqueada"
        else
            iptables -A INPUT -s "$ip_target" -j DROP
            echo ">> IP bloqueada: $ip_target"
        fi
    else
        echo "Todo bien por ahora"
    fi

    echo "Durmiendo $INTERVAL segundos..."
    sleep $INTERVAL
done


