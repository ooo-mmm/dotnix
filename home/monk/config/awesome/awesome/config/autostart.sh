#!/usr/bin/env bash

function run {
  if ! [[ "$(pgrep -f "$1")" ]]; then
    "$@" &
  fi
}

run picom
run xrdb -load "$HOME/.Xresources"
run xwallpaper --stretch "$HOME/Pictures/Wallpapers/wallpaper.jpg"
run setxkbmap -option caps:escape

xrandr --output DP-0 --primary --mode 3440x1440 --pos 0x1080 --rotate normal --output DP-1 --off --output HDMI-0 --mode 2560x1080 --pos 383x0 --rotate normal --output DP-2 --off --output DP-3 --off --output HDMI-1 --off --output DP-4 --off --output DP-5 --off
