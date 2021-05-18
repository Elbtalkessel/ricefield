# Profile file. Runs on login. Environmental variables are set here.
# https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOWNLOAD_DIR="$HOME/Download"
export XDG_RUNTIME_DIR=/run/user/$(id -u)

if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CLIENT" ]
then
    export XDG_CURRENT_DESKTOP="SSH"
else
    [ "$(tty)" = "/dev/tty1" ] && export XDG_CURRENT_DESKTOP="DWM"
    [ "$(tty)" = "/dev/tty2" ] && export XDG_CURRENT_DESKTOP="DWM"
fi

export BIN_HOME="$HOME/.local/bin"
export SOURCE_HOME="$HOME/.local/src"
if [ "$XDG_CURRENT_DESKTOP" != "SSH" ]
then
    export BACKUPS_DIR="/mnt/storage/Backups"
    export PROJECTS_DIR="$HOME/Projects"
fi

# Adds `~/.local/bin` and children dir to $PATH
# sed doesn't replace last occurency as tr does, dk why but it desirable
export PATH="$PATH:$(find $BIN_HOME -type d | grep -v "__" | sed ':a;N;$!ba;s/\n/:/g')"

# Default programs:
if [ "$XDG_CURRENT_DESKTOP" = "SSH" ]
then
    export EDITOR="vim"
else
    export EDITOR="nvim"
    export TERMINAL="st"
    export BROWSER="qutebrowser"
    export READER="zathura"
fi

# ~/ Clean-up:
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NVM_DIR="$SOURCE_HOME/nvm"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
# fixes only user prefrences, directories .java/fonts and something else will remain
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
# Breaks LightDM, ~/.Xauthority path hardcoded in SLiM
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
# pg dirs should be created before hand
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
# should be created
export PYTHONSTARTUP="$XDG_DATA_HOME/python_history"

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$BIN_HOME/dmenupass"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

# https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
# (for pycharm)
export _JAVA_AWT_WM_NONREPARENTING=1

# Dev
export FIRESTORE_EMULATOR_HOST="127.0.0.1:8686"
if [ "$XDG_CURRENT_DESKTOP" != "SSH" ]
then
    export PATH="$PATH:$(yarn global bin)"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$XDG_CONFIG_HOME/bash/bashrc" ]; then
        . "$XDG_CONFIG_HOME/bash/bashrc"
    fi
fi

# Start graphical server on tty1|2 if not already running.
[ "$XDG_CURRENT_DESKTOP" != "SSH" ] && ! pgrep -x Xorg >/dev/null && exec startx -- -ardelay 200 -arinterval 50
