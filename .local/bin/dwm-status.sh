#!/bin/bash
#CHECK="$HOME/.local/bin/dwm-status-bar"
CHECK="$HOME/.cargo/bin/rs-status"
while :; do
  CMD=$CHECK
  if [ ! -f "$CHECK" ]; then
    echo "$CMD not found"
    CMD="date"
  fi
	xsetroot -name "$(bash -c $CMD)"  
	sleep 1
done
