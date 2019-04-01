#!/bin/bash

function join_by {
  local d=$1
  shift
  echo -n "$1"
  shift
  printf "%s" "${@/#/$d}"
}

IFS=: read -r -d '' -a path_array < <(printf '%s:\0' "$PATH")
npath=()
for p in "${path_array[@]}"; do
  echo "$p" | grep "/apollo/" > /dev/null
  if [ $? -ne 0 ]; then
    npath+=("$p")
  fi
done

PATH=$(join_by : "${npath[@]}") make test-coverage
