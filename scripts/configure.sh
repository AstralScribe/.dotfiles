#!/usr/bin/env bash

set -euo pipefail

TEMP_PATH="$HOME/.cache/myde/temp"
SCRIPT_PATH="$(pwd)/scripts"
DRY_RUN=false

source "$SCRIPT_PATH/helpers.sh"

while (( $# > 0 )); do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=true
      ;;
    -h|--help)
      printf 'Usage: %s [--dry-run]\n' "$0"
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      printf 'Usage: %s [--dry-run]\n' "$0" >&2
      exit 1
      ;;
  esac
  shift
done

