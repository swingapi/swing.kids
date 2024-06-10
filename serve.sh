#!/bin/bash

[ -n "$1" ] && lang=$1 || lang="en"

# shellcheck source=/dev/null
source .venv/bin/activate
mkdocs serve --config-file "config/$lang/mkdocs.yml"
