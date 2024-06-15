#!/bin/sh
#
# A convenient script to serve a live site when use Python venv.
#

[ -n "$1" ] && lang=$1 || lang="en"
[ -n "$2" ] && host=$2 || host="localhost"

config_file="config/$lang/mkdocs.yml"
printf "\n- Host: $host\n- Config File: %s\n\n" "$config_file"

if [ -d ".venv" ]; then
  # shellcheck source=/dev/null
  . ".venv/bin/activate"
fi

mkdocs serve -a "$host:8000" --config-file "$config_file"
