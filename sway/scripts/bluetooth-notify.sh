#!/bin/bash

# Monitor Bluetooth connections
bluetoothctl -- monitor | while read -r line; do
    if echo "$line" | grep -q "Device Connected"; then
        DEVICE_NAME=$(echo "$line" | awk '{print $3}')
        notify-send "Bluetooth Device Connected" "Device: $DEVICE_NAME"
    fi
done
