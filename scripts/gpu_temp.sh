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

gpu_temp=$(read_temp "$GPU_PATH")

if [ -z "$gpu_temp" ]; then
    echo ""
    exit 1
fi

if [ "$gpu_temp" -le 55 ]; then
    state="low"
elif [ "$gpu_temp" -le 75 ]; then
    state="normal"
elif [ "$gpu_temp" -le 90 ]; then
    state="warning"
else
    state="critical"
fi

echo "{\"text\": \"$gpu_temp\", \"class\": \"$state\", \"alt\": \"$state\", \"tooltip\": \"GPU: $gpu_temp°C (Hot Spot)\", \"percentage\": $gpu_temp}"
