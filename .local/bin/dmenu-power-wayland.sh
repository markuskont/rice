#!/bin/bash

whatdo=$(echo -e "lock\nsuspend\nshutdown\nreboot\nhibernate"|wofi --dmenu)

case $whatdo in
  "lock")           ~/.local/bin/lockman.sh;;
  "reboot")         reboot;;
  "shutdown")       shutdown -h now;;
  "suspend")        systemctl suspend;;
  "hibernate")        systemctl hibernate;;
esac
