#!/bin/sh

# xinitrc runs automatically when you run startx.
# things to be started in background
sxhkd >| $HOME/.local/share/logs/sxhkd_$(date -I).log 2>&1 &
dunst -conf $XDG_CONFIG_HOME/dunst/dunstrc &
mpd &
unclutter & # Remove mouse when idle
mpd-module-update & # Check for when to update the mpd module
xset r rate 300 50 &
setkeys &

# Fix Gnome Apps Slow  Start due to failing services
# Add this when you include flatpak in your system
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# or blackscreen on nvidia gpu
xrandr --auto
xrdb ~/.config/Xresources
xrdb ~/.cache/wal/colors.Xresources

if [ "$(tty)" = "/dev/tty1" ] || [ "$(tty)" = "/dev/tty2" ]
then
  # order is imporant, I'm not sure why dwmblocks is rendering in higher dpi
  # if monitors script finishes after dwm (yes _dwm_)
  dwmblocks & # start blocks and wait, they should run before *monitors*
	while ! pgrep -x dwmblocks; do sleep 0.3; done;
  monitors &  # set primary display, dpi, etc. starts xcompmgr
  while ! pgrep -x xcompmgr; do sleep 0.3; done;
  while :; do
	  ssh-agent dwm || break
  done
fi

