#!/usr/bin/env bash

function send_notification() {
    brightness=$(brightnessctl get | awk '{printf "%.0f\n", $1 / 255 * 100}')
    dunstify -a "changebrightness" -u low -r 8877 -h int:value:"$brightness" -i "brightness-$1" "Brightness: ${brightness}%" -t 2000
}

case $1 in
    up)
        brightnessctl set 5%+
        send_notification $1
        ;;
    down)
        brightnessctl set 5%- 
        send_notification $1
        ;;
esac
