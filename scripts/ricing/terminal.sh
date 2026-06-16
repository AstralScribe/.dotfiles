#!/usr/bin/env bash

set -euo pipefail

SCRIPT_PATH="$(pwd)/scripts"
DRY_RUN=false
source "${SCRIPT_PATH}/helpers.sh"

while (( $# > 0 )); do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=true
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      printf 'Usage: %s [--dry-run]\n' "$0" >&2
      exit 1
      ;;
  esac
  shift
done

if [[ "$DRY_RUN" == true ]]; then
  log "terminal" "$YELLOW" "DRY RUN enabled; no changes will be applied"
fi

run "terminal" "$BLUE" "$DRY_RUN" cp "${CONFIG_PATH}/.zshrc" "$HOME/.zshrc"
run "terminal" "$BLUE" "$DRY_RUN" cp "${CONFIG_PATH}/.p10k.zsh" "$HOME/.p10k.zsh"
run "terminal" "$BLUE" "$DRY_RUN" cp -r "${CONFIG_PATH}/zsh" "$HOME/.config/"
log "terminal" "$GREEN" "terminal setup completed"
