#!/bin/bash

whatdo=$(echo -e "suspend\nshutdown\nreboot"|dmenu -fn "hack 9")

case $whatdo in
  "reboot")         reboot;;
  "shutdown")       shutdown -h now;;
  "suspend")        systemctl suspend;;
esac
