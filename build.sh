#!/bin/sh

readonly filter_lang="$1"

LANGS="${LANGS} en"
LANGS="${LANGS} zh-Hans"

if [ -d ".venv" ]; then
  # shellcheck source=/dev/null
  . .venv/bin/activate
fi

for lang in ${LANGS}; do
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
