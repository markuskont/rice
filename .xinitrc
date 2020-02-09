#!/bin/bash

SESSION=REPLACE

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.xprofile ] && source ~/.xprofile
xrdb -merge ~/.Xresources

exec $SESSION
