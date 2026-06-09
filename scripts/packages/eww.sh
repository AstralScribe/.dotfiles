#!/usr/bin/env bash

set -eou pipefail

TEMP_PATH="${HOME}/.cache/myde/temp"
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

if command -v eww >/dev/null 2>&1; then
  log "eww" "${YELLOW}" "eww already installed; skipping installation"
  exit 0
fi

log "eww" "${BLUE}" "Starting eww installation"
run "eww" "${BLUE}" "${DRY_RUN}" mkdir -p "${TEMP_PATH}"
log "eww" "${BLUE}" "Cloning eww repository into ${TEMP_PATH}/eww"
run "eww" "${BLUE}" "${DRY_RUN}" git clone https://github.com/elkowar/eww "${TEMP_PATH}/eww"
if [[ "${DRY_RUN}" == true ]]; then
  log "eww" "${BLUE}" "DRY RUN: cd ${TEMP_PATH}/eww"
else
  log "eww" "${BLUE}" "Entering repository directory"
  cd "${TEMP_PATH}/eww"
fi
log "eww" "${BLUE}" "Building eww with wayland feature"
run "eww" "${BLUE}" "${DRY_RUN}" cargo build --release --no-default-features --features=wayland
if [[ "${DRY_RUN}" == true ]]; then
  log "eww" "${BLUE}" "DRY RUN: cd target/release"
else
  log "eww" "${BLUE}" "Entering build output directory"
  cd target/release
fi
log "eww" "${BLUE}" "Making eww binary executable"
run "eww" "${BLUE}" "${DRY_RUN}" chmod +x ./eww

log "eww" "${BLUE}" "Installing binary to ${HOME}/.local/bin"
run "eww" "${BLUE}" "${DRY_RUN}" mkdir -p "${HOME}/.local/bin"
run "eww" "${BLUE}" "${DRY_RUN}" cp eww "${HOME}/.local/bin"
log "eww" "${BLUE}" "Finished installing eww"

