#!/bin/bash

# Ponto de montagem que você quer monitorar
mount_point="/"

# Obtém o uso de disco
read total used available percent <<< $(df -h "$mount_point" | awk 'NR==2 {print $2, $3, $4, $5}' | tr -d '%')

tooltip="Uso do disco em $mount_point:\nTotal: $total\nUsado: $used\nDisponível: $available\nUtilização: ${percent}%"

echo "{\"percentage\": $percent, \"alt\": \"$tooltip\"}"

if [ "$percent" -lt 10 ]; then
    icon="󰝦"
elif [ "$percent" -lt 22 ]; then
    icon="󰪞"
elif [ "$percent" -lt 33 ]; then
    icon="󰪟"
elif [ "$percent" -lt 45 ]; then
    icon="󰪠"
elif [ "$percent" -lt 55 ]; then
    icon="󰪡"
elif [ "$percent" -lt 67 ]; then
    icon="󰪢"
elif [ "$percent" -lt 78 ]; then
    icon="󰪣"
elif [ "$percent" -lt 90 ]; then
    icon="󰪤"
else
    icon="󰪥"
fi

echo "{\"percentage\": $percent}"
# Monta o JSON para o Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"Uso do disco em $mount_point:\nTotal: $total\nUsado: $used\nDisponível: $available\nUtilização: $percent%\"}"

