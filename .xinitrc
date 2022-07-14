SESSION=i3

printf "starting %s \n" $SESSION

export GTK_THEME=gruvbox-dark-gtk
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME=gtk2

xrdb -merge ~/.Xresources
exec $SESSION
