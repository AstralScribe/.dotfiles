#!/usr/bin/env bash

set -eou pipefail

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

if [[ ! -f /etc/pacman.conf ]]; then
  log "pacman" "${RED}" "Missing /etc/pacman.conf; cannot continue"
  exit 1
fi

if [[ ! -f /etc/pacman.conf.hyde.bkp ]]; then
  log "pacman" "${BLUE}" "Creating pacman.conf backup"
  run "pacman" "${CYAN}" "${DRY_RUN}" sudo cp /etc/pacman.conf /etc/pacman.conf.hyde.bkp
else
  log "pacman" "${YELLOW}" "Backup already exists at /etc/pacman.conf.hyde.bkp"
fi

log "pacman" "${BLUE}" "Applying pacman configuration"
run "pacman" "${CYAN}" "${DRY_RUN}" sudo sed -i \
  -e 's/^#Color$/Color/' \
  -e 's/^#VerbosePkgLists$/VerbosePkgLists/' \
  -e 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' \
  -e '/^#\[multilib\]/,+1 s/^#//' \
  /etc/pacman.conf

if [[ "${DRY_RUN}" == true ]]; then
  log "pacman" "${CYAN}" "DRY RUN: ensure ILoveCandy exists after Color"
else
  if ! grep -q '^ILoveCandy$' /etc/pacman.conf; then
    log "pacman" "${BLUE}" "Adding ILoveCandy"
    sudo sed -i '/^Color$/a ILoveCandy' /etc/pacman.conf
  else
    log "pacman" "${YELLOW}" "ILoveCandy already configured"
  fi
fi

log "pacman" "${BLUE}" "Updating package databases and system"
run "pacman" "${CYAN}" "${DRY_RUN}" sudo pacman -Syyu --noconfirm
log "pacman" "${CYAN}" "Pacman setup complete"
