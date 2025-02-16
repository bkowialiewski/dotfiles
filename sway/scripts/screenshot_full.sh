#!/usr/bin/env bash

folder="$HOME/pictures/screenshots"
path="$folder"/"$(date +%Y-%m-%d--%H-%M-%S)".png 
grim "$path"
echo $path | wl-copy
