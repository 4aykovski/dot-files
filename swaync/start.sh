!/usr/bin/env bash

killall dunst
pkill dunst

killall swaync
pkill swaync

sleep 0.1

swaync  -s ~/.config/swaync/style.css & 
