#!/usr/bin/env zsh


function _path_to_array() {
  p=(`echo $PATH | sed 's/:/\n/g'`)
  echo $p
}


function path.ls() {
  for i in `_path_to_array`
  do
    echo $i
  done
}


function path.rm() {
  local result
  for p in `_path_to_array`
  do
    for arg in "$@"
    do
      if [ "$p" != "$arg" ]
      then
        if [ -z "$result" ]
        then
          result="$p"
        else
          result="${result}:${p}"
        fi
      fi
    done
  done
  export PATH=$result
}


function path.add() {
  case ":$PATH:" in
    *":$1:"*) return ;;
    *) PATH="$1:$PATH" ;;
  esac
}


function _pathcompdef() {
  # I have no clue what I am doing here
  compadd $(_path_to_array)
}
compdef _pathcompdef path.rm
