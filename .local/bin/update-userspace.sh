#!/bin/bash

sudo pacman -Syy --needed --noconfirm firefox-developer-edition chromium
pkill firefox
pkill chromium
sleep 3
bspc wm -r
