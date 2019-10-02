#!/usr/bin/env bash

export DID_PATH=${DID_PATH:-$HOME"/.did"}
export DID_EDITOR=${DID_EDITOR:-$VISUAL}
export DID_EDITOR_PARAMS=${DID_EDITOR_PARAMS:-""}

local OWN_PATH=$(dirname $0)
local OWN_PATH=$(realpath $OWN_PATH)

function _did_init() {
  if [ ! -d "$DID_PATH" ]; then
    echo "Creating did folder: $DID_PATH"
    mkdir $DID_PATH
  fi
}

function _did_init_year_dir() {
  local YEAR=$($OWN_PATH/year.py)
  if [ ! -d "$DID_PATH/$YEAR" ]; then
    mkdir "$DID_PATH/$YEAR"
  fi
}

function _did_init_week_file() {
  local YEAR=$($OWN_PATH/year.py)
  local WEEK=$($OWN_PATH/week.py)
  local WEEK_FILE="$YEAR-$WEEK.md"
  local WEEK_FILE_PATH="$DID_PATH/$YEAR/$WEEK_FILE"
  local JUST_CREATED="no"
  if [ ! -f "$WEEK_FILE_PATH" ]; then
    local JUST_CREATED="yes"
    echo "# Week $WEEK of $YEAR\n" > $WEEK_FILE_PATH
    echo "Created file: $WEEK_FILE_PATH"
  fi

  if [ "$JUST_CREATED" = "yes" ] || ! $OWN_PATH/was_edited_today.py $WEEK_FILE_PATH; then
    local TODAY=$(date '+%A %-d. %B')
    echo "## $TODAY\n" >> $WEEK_FILE_PATH
  fi

  $DID_EDITOR $DID_EDITOR_PARAMS $WEEK_FILE_PATH
}

function _did_list() {
  array=()
  find $DID_PATH -name "*.md" -print0 | sort -r > tmpfile
  while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
  done <tmpfile
  rm -f tmpfile
  for JOURNAL in $array; do
    if [ "$1" = "" ]; then
      cat "$JOURNAL"
    else
      grep --with-filename $1 $JOURNAL
    fi
  done
}

function did() {
  _did_init
  _did_init_year_dir
  if [ "$1" = "ls" ]; then
    _did_list $2
  else
    _did_init_week_file
  fi
}
