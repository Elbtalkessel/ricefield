#!/bin/sh

# xinitrc runs automatically when you run startx.
# things to be started in background
sxhkd &
dunst -conf $XDG_CONFIG_HOME/dunst/dunstrc &
unclutter & # Remove mouse when idle
setkeys &
calcurse --daemon
vorta -d

xset -dpms  # turn off Display Power Management Service (DPMS)
setterm -powerdown 0
xset s off  # turn off black Screensaver

xrdb -load $HOME/.cache/wal/colors.Xresources
xrdb -merge $HOME/.config/Xresources

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

if [ "$XDG_CURRENT_DESKTOP" = "DWM" ]
then
  setbg  # set background image
  bgtext # draws a text over set background

  keeprunning dwmblocks &
  waitfor dwmblocks

  # c: shadows; f: smooth fade; F: fade on opacity change; D: transition speed
  keeprunning xcompmgr -cfF -o 0.1 -D 1.5 &
  waitfor xcompmgr

  keeprunning mpd-module-update &

  while :; do
	  ssh-agent dwm || break
  done
fi

