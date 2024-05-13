#!/bin/bash

readonly filter_region_code=$1
readonly MAPPINGS=(
  "default:"
  "zh-Hans:zh_CN"
)

# shellcheck source=/dev/null
source .venv/bin/activate

for mapping in "${MAPPINGS[@]}" ; do
  region_code="${mapping%%:*}"
  lang="${mapping##*:}"

  if [ -n "$filter_region_code" ] && [ "$region_code" != "$filter_region_code" ]; then
    continue
  fi

  echo
  echo "# Start building for $region_code ..."
  echo

  if [ -z "$lang" ]; then
    make html
  else
    make -e \
      SPHINXOPTS="-D language='$lang'" \
      SOURCEDIR="./src/$region_code" \
      BUILDDIR="./build/$region_code" \
      html

    if [ -d "build/html" ]; then
      cp_dest="./build/html/$region_code"
      [ -d "$cp_dest" ] && rm -rf "$cp_dest"
      cp -rf "./build/$region_code/html" "$cp_dest"
    fi
  fi

  if [ -n "$filter_region_code" ]; then
    break
  fi
done