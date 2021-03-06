#!/usr/bin/env bash

export DID_PATH=${DID_PATH:-$HOME"/.did"}
export DID_EDITOR=${DID_EDITOR:-$VISUAL}
export DID_EXT=${DID_EXT:-"md"}
export DID_EDITOR_PARAMS=${DID_EDITOR_PARAMS:-""}

export DID_BIN_PATH=$(dirname $0)
export DID_BIN_PATH=$(realpath $DID_BIN_PATH)

function _did_init() {
  if [ ! -d "$DID_PATH" ]; then
    echo "Creating did folder: $DID_PATH"
    mkdir $DID_PATH
  fi
}

function _did_init_year_dir() {
  local YEAR=$($DID_BIN_PATH/year.py)
  if [ ! -d "$DID_PATH/$YEAR" ]; then
    mkdir "$DID_PATH/$YEAR"
  fi
}

function _did_get_ext() {
  if [ "$DID_EXT" != "" ]; then
    echo ".$DID_EXT"
  fi
  echo ""
}

function _did_init_week_file() {
  local YEAR=$($DID_BIN_PATH/year.py)
  local WEEK=$($DID_BIN_PATH/week.py)
  local EXT=$(_did_get_ext)
  local WEEK_FILE="$YEAR-$WEEK$EXT"
  local WEEK_FILE_PATH="$DID_PATH/$YEAR/$WEEK_FILE"
  local JUST_CREATED="no"
  if [ ! -f "$WEEK_FILE_PATH" ]; then
    local JUST_CREATED="yes"
    echo "# Week $WEEK of $YEAR\n" > $WEEK_FILE_PATH
    echo "Created file: $WEEK_FILE_PATH"
  fi

  if [ "$JUST_CREATED" = "yes" ] || ! $DID_BIN_PATH/was_edited_today.py $WEEK_FILE_PATH; then
    local TODAY=$(date '+%A %-d. %B')
    echo "\n## $TODAY\n" >> $WEEK_FILE_PATH
  fi

  $DID_EDITOR $DID_EDITOR_PARAMS $WEEK_FILE_PATH
  echo "$(echo "$(tac "$WEEK_FILE_PATH")" | tac)" > $WEEK_FILE_PATH.tmp
  mv $WEEK_FILE_PATH.tmp $WEEK_FILE_PATH
}

function _did_grep() {
  array=()
  local EXT=$(_did_get_ext)
  find $DID_PATH -name "*$EXT" -print0 | sort -r > tmpfile
  while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
  done <tmpfile
  rm -f tmpfile
  for JOURNAL in $array; do
    if [ "$1" = "" ]; then
      echo "\n================================================================================\n";
      cat "$JOURNAL"
    else
      grep --ignore-case --with-filename $1 $JOURNAL
    fi
  done
}

function _did_list() {
  array=()
  local EXT=$(_did_get_ext)
  find $DID_PATH -name "*$EXT" -print0 | sort -r > tmpfile
  while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
  done <tmpfile
  rm -f tmpfile
  for JOURNAL in $array; do
    if [ "$1" = "" ]; then
      echo "$JOURNAL"
    fi
  done
}

function did() {
  _did_init
  _did_init_year_dir
  if [ "$1" = "grep" ]; then
    _did_grep $2
  elif [ "$1" = "ls" ]; then
    _did_list $2
  else
    _did_init_week_file
  fi
}
