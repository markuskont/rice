#!/bin/bash
#xrandr --auto
#xrandr --dpi 96
source ~/.profile
[ -f ~/.xprofile ] && source ~/.xprofile
exec dwm
