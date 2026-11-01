#!/bin/bash

if bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power off
    notify-send -a "Waybar" -i "bluetooth-disabled" "Bluetooth" "Desligado"
else
    bluetoothctl power on
    notify-send -a "Waybar" -i "bluetooth-active" "Bluetooth" "Ligado"
fi
