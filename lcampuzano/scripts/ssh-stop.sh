#!/bin/bash


while true; do

 target=$(netstat -tapn |awk '{print $5}' |grep -E ^[0-9] |cut -d: -f1|sort|uniq -c|sed -r 's/^[[:space:]]+//g' |sort -k1 -n -r |head -1)


 number_of_connections=$(echo "$target" | awk  '{print $1}')
 ip_target=$(echo "$target" | awk  '{print $2}')


echo "Numero de conexiones: $number_of_connections"
echo "IP target: $ip_target"



if [ $number_of_connections  -gt 99 ]; then
    echo "Bloquear IP"
    if iptables -C INPUT -s $ip_target#!/bin/bash

# Límite de conexiones SSH permitidas por IP
LIMIT=10

# Intervalo entre revisiones
INTERVAL=15

while true; do
    echo "[$(date)] Analizando conexiones SSH activas..."

    # Obtener IPs con conexiones establecidas al puerto 22
    ss -tn state established '( sport = :ssh )' | awk 'NR>1 {print $4}' | cut -d: -f1 \
    | sort | uniq -c | sort -nr > /tmp/ssh_conn_list.txt

    while read count ip; do
        echo "IP: $ip - Conexiones SSH: $count"
        if [ "$count" -gt "$LIMIT" ]; then
            echo ">> Se excedió el límite: $ip con $count conexiones"
            if iptables -C INPUT -s "$ip" -p tcp --dport 22 -j DROP 2>/dev/null; then
                echo ">> La IP ya está bloqueada"
            else
                iptables -A INPUT -s "$ip" -p tcp --dport 22 -j DROP
                echo ">> IP bloqueada: $ip"
            fi
        fi
    done < /tmp/ssh_conn_list.txt

    echo "Dormir $INTERVAL segundos..."
    sleep $INTERVAL
done -j DROP  2>/dev/null; then
        echo "La regla ya existe"
    else
        iptables -A INPUT -s $ip_target -j DROP
        echo "IP bloqueada $ip_target"
    fi
else
    echo "Todo bien"
fi

   sleep 15
done
