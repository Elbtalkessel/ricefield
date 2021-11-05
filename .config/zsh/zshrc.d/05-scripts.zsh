#!/bin/zsh


iptobin() {
  ip=""
  for decimal in `echo ${1} | tr '.' ' '`; do
    converted=`bc <<< "obase=2;$decimal"`
    padded=`printf '%08d' $converted`
    if [ ! -z "$ip" ]; then
      padded=" $padded"
    fi
    ip="${ip}${padded}"
  done
  echo $ip
}


colors() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f";
  done
}


prj() {
  if [ -z $1 ]
  then
    cd "$PROJECTS_DIR"
    ll
  else
    local project=$(ls "$PROJECTS_DIR" | grep "$1")
    deactivate > /dev/null 2>&1
    cd "${PROJECTS_DIR}/${project}"
    if [ -d "${WORKON_HOME}/${project}" ]
    then
      workon "${project}"
    fi
  fi
}
compctl -W "${PROJECTS_DIR}" -/ prj


arc() {
  local dst="${BACKUPS_DIR}/fsa/$(basename $1).fsa"
  local src="$1"
  sudo fsarchiver savedir -A -j8 -Z 15 -v -o "$dst" "$src"
}


darc() {
  local src="${BACKUPS_DIR}/fsa/$(basename $1)"
  sudo fsarchiver restdir "$src" .
}
compctl -W "$BACKUPS_DIR" -f darc


arcprj() {
  cmpr() {
    local dst="${BACKUPS_DIR}/fsa/$(basename $1).fsa"
    local src="${PROJECTS_DIR}/$1"
    sudo fsarchiver savedir \
        -A -j8 -Z 15 -v \
        -e "node_modules" \
        -e "*.pyc" \
        -e ".env/*" \
        -o "$dst" "$src" \
        && ls -ahs $dst

  }
  for arg in "$@"
  do
      cmpr $arg
  done
}
compctl -W "$PROJECTS_DIR" -/ arcprj


darcprj() {
  local src="${BACKUPS_DIR}/fsa/$1"
  # fsarchiver keeps full path
  sudo fsarchiver restdir "$src" "/"
}
compctl -W "$BACKUPS_DIR/$(basename $PROJECTS_DIR)" -f darcprj


arcls() {
  diff  <(ls $PROJECTS_DIR | awk 1 ORS='\n') <(ls ${BACKUPS_DIR}/fsa | awk 1 ORS='\n' | sed 's,.fsa,,g') -y
}


lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}


nvm() {
  if [ ! -z "$NVM_DIR" ]
  then
    source "$NVM_DIR/nvm.sh"
  fi
  nvm $@
}


viw() {
    vi `which $1`
}
compctl -m viw

