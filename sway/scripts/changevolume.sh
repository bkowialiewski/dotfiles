#!/usr/bin/env bash

function send_notification() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $NF * 100}')
    dunstify -a "changevolume" -u low -r 8877 -h int:value:"$volume" -i "volume-$1" "Volume: ${volume}%" -t 2000
}

case $1 in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ 
        send_notification $1
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification $1
        ;;
    mute)
        status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $NF}')
        if [ $status = "[MUTED]" ]; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            dunstify -a "changevolume" -u low -r 8877 "Volume ON" -t 2000
        else
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            dunstify -a "changevolume" -u low -r 8877 "Volume OFF" -t 2000
        fi
esac

