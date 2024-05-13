#!/bin/bash

readonly filter_region=$1

readonly SOURCE_ROOT="src"
readonly BUILD_ROOT="build"

readonly DEFAULT_LANG="en"
readonly MAPPINGS=(
  "en:en"
  "zh-Hans:zh_CN"
)

# shellcheck source=/dev/null
source .venv/bin/activate

config_base_file="$SOURCE_ROOT/_conf.py"

for mapping in "${MAPPINGS[@]}" ; do
  region="${mapping%%:*}"
  lang="${mapping##*:}"

  if [ -n "$filter_region" ] && [ "$region" != "$filter_region" ]; then
    continue
  fi

  # Source and build dirs.
  input_dir="$SOURCE_ROOT/$region"
  [ "$lang" = "$DEFAULT_LANG" ] && output_dir="$BUILD_ROOT" || output_dir="$BUILD_ROOT/$region"

  # Setup conf.py file.
  config_override_file="$input_dir/_conf.py"

  if [ -f "$config_base_file" ] && [ -f "$config_override_file" ]; then
    config_file="$input_dir/conf.py"
    echo -e "\n# Setup $config_file ...\n"
    cp -v "$config_base_file" "$config_file"
    cat "$config_override_file" >> "$config_file"
  fi

  # Build.
  echo -e "\n# Start building for $region ...\n"
  make -e \
    SPHINXOPTS="-D language='$lang'" \
    SOURCEDIR="$input_dir" \
    BUILDDIR="$output_dir" \
    html

  if [ -n "$filter_region" ]; then
    break
  elif [ "$lang" = "$DEFAULT_LANG" ]; then
    continue
  fi

  # Migrate html outputs.
  if [ -d "$BUILD_ROOT/html" ]; then
    cp_dest="$BUILD_ROOT/html/$region"
    [ -d "$cp_dest" ] && rm -rf "$cp_dest"
    cp -rf "$output_dir/html" "$cp_dest"
  fi
done
