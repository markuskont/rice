#!/bin/bash

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  MONITOR=$m polybar --config=${HOME}/.config/polybar/$(hostname -s).conf --reload ${SESSION} &
done

echo "Bars launched..."
