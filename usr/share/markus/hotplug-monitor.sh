#! /usr/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/markus/.Xauthority

IN=LVDS-1
OUT1=DP-1
OUT2=HDMI-1

function connect(){
  xrandr  --output $OUT1 --right-of $IN --preferred --primary \
          --output $IN --off
  feh --bg-fill /usr/share/markus/wall.pic
}
  
function disconnect(){
  xrandr  --output $OUT1 --off \
          --output $OUT2 --off \
          --output $IN --auto --primary
  feh --bg-fill /usr/share/markus/wall.pic
}
   
#xrandr | grep "HDMI1 connected" &> /dev/null && connect || disconnect
xrandr | egrep "($OUT1|$OUT2) connected" &> /dev/null && connect || disconnect
