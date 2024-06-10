#!/bin/bash

readonly filter_lang=$1
readonly LANGS=(
  "en"
  "zh-Hans"
)

# shellcheck source=/dev/null
source .venv/bin/activate

for lang in "${LANGS[@]}" ; do
  if [ -n "$filter_lang" ] && [ "$lang" != "$filter_lang" ]; then
    continue
  fi

  echo
  echo "# Start building for lang:$lang ..."
  echo

  mkdocs build --config-file "config/$lang/mkdocs.yml"

  if [ -n "$filter_lang" ]; then
    break
  fi
done
