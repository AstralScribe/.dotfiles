#!/usr/bin/env bash

set -eou pipefail

SCRIPT_PATH="$(pwd)/scripts"

source "${SCRIPT_PATH}/helpers.sh"

log "services" "${CYAN}" "Enabling NetworkManager"
run "services" "${CYAN}" false sudo systemctl enable networkmanager --now &> /dev/null || log "services" "${RED}" "Couldn't enable NetworkManager"

log "services" "${CYAN}" "Enabling Bluetooth"
run "services" "${CYAN}" false sudo systemctl enable bluetooth --now  &> /dev/null || log "services" "${RED}" "Couldn't enable Bluetooth"

log "services" "${CYAN}" "Enabling SDDM"
run "services" "${CYAN}" false sudo systemctl enable sddm &> /dev/null || log "services" "${RED}" "Couldn't enable SDDM"

log "services" "${CYAN}" "Service setup complete"
