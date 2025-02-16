#!/usr/bin/env bash
pkill kanshi && sleep 1
kanshi &

pkill yambar && sleep 1
yambar &

pkill dunst && sleep 1
dunst &

# pkill waybar && sleep 1
# waybar &
