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

if [[ "$DRY_RUN" == true ]]; then
  log "tmux" "$YELLOW" "DRY RUN enabled; no changes will be applied"
fi

run "tmux" "$BLUE" "$DRY_RUN" mkdir -p "$TEMP_PATH/tmux"
run "tmux" "$BLUE" "$DRY_RUN" git clone https://github.com/tmux-plugins/tmux-resurrect "$TEMP_PATH/tmux/tmux-resurrect"
run "tmux" "$BLUE" "$DRY_RUN" git clone https://github.com/christoomey/vim-tmux-navigator "$TEMP_PATH/tmux/vim-tmux-navigator"
run "tmux" "$BLUE" "$DRY_RUN" git clone https://github.com/tmux-plugins/tmux-sensible "$TEMP_PATH/tmux/tmux-sensible"
run "tmux" "$BLUE" "$DRY_RUN" git clone https://github.com/tmux-plugins/tpm "$TEMP_PATH/tmux/tpm"
run "tmux" "$BLUE" "$DRY_RUN" git clone https://github.com/catppuccin/tmux "$TEMP_PATH/tmux/tmux"

run "tmux" "$BLUE" "$DRY_RUN" mkdir -p "$HOME/.tmux/plugins"
run "tmux" "$BLUE" "$DRY_RUN" cp -r "$TEMP_PATH/tmux" "$HOME/.tmux/plugins"

run "tmux" "$BLUE" "$DRY_RUN" cp "$SCRIPT_PATH/../configs/tmux.conf" "$HOME/.tmux.conf"

log "tmux" "$GREEN" "tmux setup completed"