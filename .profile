# Profile file. Runs on login. Environmental variables are set here.
# https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOWNLOAD_DIR="$HOME/Download"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
[ "$(tty)" = "/dev/tty2" ] && export XDG_CURRENT_DESKTOP="DWM"


# Other directories can be used in scripts
export BIN_HOME="$HOME/.local/bin"
export SOURCE_HOME="$HOME/.local/src"
export BACKUPS_DIR="/mnt/storage/Backups"
export PROJECTS_DIR="$HOME/Projects"


# Adds `~/.local/bin` and children dir to $PATH
# sed doesn't replace last occurency as tr does, dk why but it desirable
# FIXME: doesn't work for symlinks to a directory
export PATH="$PATH:$(find $BIN_HOME -maxdepth 1 -type d | grep -v "__" | sed ':a;N;$!ba;s/\n/:/g')"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(HOME=$XDG_DATA_HOME yarn global bin)"


# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"


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
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/credentials"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export POETRY_HOME="$XDG_DATA_HOME/poetry"
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases
export HISTFILE="$XDG_DATA_HOME/bash/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# https://github.com/npm/npm/issues/6675#issuecomment-251049832
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
export GOPATH=$SOURCE_HOME/go
export GOBIN=$BIN_HOME/go
export CARGO_HOME=$XDG_CACHE_HOME/cargo
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup


# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$BIN_HOME/dmenupass"
# less
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
# vm
export VAGRANT_DEFAULT_PROVIDER=kvm
export VIRSH_DEFAULT_CONNECT_URI='qemu:///system'
export DOCKER_BUILDKIT=1
# backups
export BORG_REPO="/mnt/storage/Backup/Borg"
# appearance
# https://wiki.archlinux.org/title/Uniform_look_for_Qt_and_GTK_applications
# style qt apps as gtk, requires qt5-styleplugins
export QT_QPA_PLATFORMTHEME=gtk2
# I didn't install xdg-desktop-portal-kde (it's for kde, to much to only make kde dialogs look ok)
export GTK_USE_PORTAL=1
# bugfixes:
# https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
# (for pycharm)
export _JAVA_AWT_WM_NONREPARENTING=1

source ~/.config/secrets

# Start X and X related
[ "$XDG_CURRENT_DESKTOP" = "DWM" ] && ! pgrep -x Xorg >/dev/null && exec startx -- -ardelay 300 -arinterval 75

