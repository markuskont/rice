#!/bin/bash

sudo pacman -Syy --needed --noconfirm firefox-developer-edition
pkill firefox && bspc wm -r
