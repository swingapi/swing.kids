#!/bin/sh
#
# Entrypoint for Dockerfile.
#

action=$1

printf "\nAction: %s\n\n" "$action"

# shellcheck source=/dev/null
. "$(dirname "$0")/../.venv/bin/activate"

if [ "$action" = "build" ]; then
  sh ./build.sh "$2"
else
  sh ./serve.sh "$2" "$3"
fi
