#!/bin/bash

LOCAL_CONFIG="$HOME/.config/waybar/scripts/local_hardware.sh"
[ -f "$LOCAL_CONFIG" ] && source "$LOCAL_CONFIG"

read_temp() {
    local path=$1
    if [ -n "$path" ] && [ -f "$path" ]; then
        echo $(($(cat "$path") / 1000))
    else
        echo ""
    fi
}

gpu_temp=$(read_temp "$GPU_PATH")

if [ -z "$gpu_temp" ]; then
    echo ""
    exit 1
fi

class=""
if [ $gpu_temp -gt 100 ]; then
  class="critical"
elif [ $gpu_temp -gt 90 ]; then
  class="warning"
fi

echo "{\"text\": \"$gpu_temp\", \"class\": \"$class\", \"tooltip\": \"GPU: $gpu_temp°C (Hot Spot)\"}"
