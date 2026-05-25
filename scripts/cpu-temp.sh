#!/bin/bash

LOCAL_CONFIG="$HOME/.config/waybar/scripts/local-hardware.sh"
[ -f "$LOCAL_CONFIG" ] && source "$LOCAL_CONFIG"

read_temp() {
    local path=$1
    if [ -n "$path" ] && [ -f "$path" ]; then
        echo $(($(cat "$path") / 1000))
    else
        echo ""
    fi
}

cpu_temp=$(read_temp "$CPU_PATH")

if [ -z "$cpu_temp" ]; then
    echo ""
    exit 1
fi

class=""
if [ $cpu_temp -gt 90 ]; then
  class="critical"
elif [ $cpu_temp -gt 80 ]; then
  class="warning"
fi

echo "{\"text\": \"$cpu_temp\", \"class\": \"$class\", \"tooltip\": \"CPU: $cpu_temp°C (Tctl)\"}"
