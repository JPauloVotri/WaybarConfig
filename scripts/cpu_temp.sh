#!/bin/bash

LOCAL_CONFIG="$HOME/.config/waybar/scripts/local_hardware.sh"
[ -f "$LOCAL_CONFIG" ] && source "$LOCAL_CONFIG"

read_temp() {
    local path=$1
    if [ -n "$path" ] && [ -f "$path" ]; then
        echo $(( $(< "$path") / 1000 ))
    else
        echo ""
    fi
}

cpu_temp=$(read_temp "$CPU_PATH")

if [ -z "$cpu_temp" ]; then
    echo ""
    exit 1
fi

if [ "$cpu_temp" -le 50 ]; then
    state="low"
elif [ "$cpu_temp" -le 70 ]; then
    state="normal"
elif [ "$cpu_temp" -le 85 ]; then
    state="warning"
else
    state="critical"
fi

echo "{\"text\": \"$cpu_temp\", \"class\": \"$state\", \"alt\": \"$state\", \"tooltip\": \"CPU: $cpu_temp°C (Tctl)\", \"percentage\": $cpu_temp}"
