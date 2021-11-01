#!/bin/bash

whatdo=$(echo -e "lock\nsuspend\nshutdown\nreboot"|dmenu)

case $whatdo in
  "reboot")         reboot;;
  "shutdown")       shutdown -h now;;
  "suspend")        systemctl suspend;;
  "lock")           ~/.local/bin/lock.sh;;
esac
