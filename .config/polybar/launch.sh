#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

case $(hostname -s) in
  sycamore)
    polybar --config=${HOME}/.config/polybar/sycamore.conf top &
    ;;
  moksha)
    polybar --config=${HOME}/.config/polybar/moksha.conf bspwm &
    ;;
  *)
    polybar top &
    ;;
esac

echo "Bars launched..."
