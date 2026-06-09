#!/usr/bin/env bash

set -eou pipefail

DRY_RUN=false

source "$(pwd)/scripts/helpers.sh"

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

log "rust" "${BLUE}" "Checking rustup installation"

if ! pkg_status "rustup"; then
  log "rust" "${GREEN}" "Installing rustup"
  run "rust" "${BLUE}" "${DRY_RUN}" sudo pacman -S --noconfirm rustup
else
  log "rust" "${YELLOW}" "rustup already installed; skipping install"
fi

log "rust" "${BLUE}" "Setting toolchain to stable"
run "rust" "${BLUE}" "${DRY_RUN}" rustup default stable
log "rust" "${BLUE}" "Rust setup complete"


