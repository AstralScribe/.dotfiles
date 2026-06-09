#!/usr/bin/env bash

set -eou pipefail

SCRIPT_PATH="$(pwd)/scripts"
DRY_RUN=false

SILENT_SDDM_REPO_URL="https://github.com/uiriansan/SilentSDDM"
SILENT_SDDM_CLONE_PATH="${HOME}/.cache/myde/temp/SilentSDDM"
SILENT_SDDM_THEME_PATH="/usr/share/sddm/themes/silent"
SILENT_SDDM_CONFIG_PATH="/etc/sddm.conf.d/10-silent.conf"

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

log "login" "${CYAN}" "Setting up SilentSDDM"
log "login" "${YELLOW}" "SilentSDDM requires SDDM v0.21.0 or newer"

if [[ -d "${SILENT_SDDM_CLONE_PATH}/.git" ]]; then
  log "login" "${CYAN}" "Refreshing existing SilentSDDM clone"
  run "login" "${CYAN}" "${DRY_RUN}" git -C "${SILENT_SDDM_CLONE_PATH}" pull --ff-only
else
  log "login" "${CYAN}" "Cloning SilentSDDM repository"
  run "login" "${CYAN}" "${DRY_RUN}" mkdir -p "${HOME}/.cache/myde/temp"
  run "login" "${CYAN}" "${DRY_RUN}" git clone -b main --depth=1 "${SILENT_SDDM_REPO_URL}" "${SILENT_SDDM_CLONE_PATH}"
fi

log "login" "${CYAN}" "Installing SilentSDDM theme files"
run "login" "${CYAN}" "${DRY_RUN}" sudo mkdir -p "${SILENT_SDDM_THEME_PATH}"
run "login" "${CYAN}" "${DRY_RUN}" sudo cp -rf "${SILENT_SDDM_CLONE_PATH}/." "${SILENT_SDDM_THEME_PATH}/"

if [[ -d "${SILENT_SDDM_THEME_PATH}/fonts" ]]; then
  log "login" "${CYAN}" "Installing SilentSDDM fonts"
  run "login" "${CYAN}" "${DRY_RUN}" sudo mkdir -p /usr/share/fonts
  run "login" "${CYAN}" "${DRY_RUN}" sudo cp -rf "${SILENT_SDDM_THEME_PATH}/fonts/." /usr/share/fonts/
else
  log "login" "${YELLOW}" "No fonts directory found in SilentSDDM theme; skipping font install"
fi

log "login" "${CYAN}" "Writing SDDM Silent theme config to ${SILENT_SDDM_CONFIG_PATH}"
if [[ "${DRY_RUN}" == true ]]; then
  log "login" "${CYAN}" "DRY RUN: sudo mkdir -p /etc/sddm.conf.d"
  log "login" "${CYAN}" "DRY RUN: write [General]/[Theme] settings for SilentSDDM to ${SILENT_SDDM_CONFIG_PATH}"
else
  tmp_config="$(mktemp)"
  cat > "${tmp_config}" <<'EOF'
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF
  run "login" "${CYAN}" "${DRY_RUN}" sudo mkdir -p /etc/sddm.conf.d
  run "login" "${CYAN}" "${DRY_RUN}" sudo cp "${tmp_config}" "${SILENT_SDDM_CONFIG_PATH}"
  rm -f "${tmp_config}"
fi

log "login" "${GREEN}" "SilentSDDM setup complete"
log "login" "${YELLOW}" "Recommended: test with /usr/share/sddm/themes/silent/test.sh before reboot"
