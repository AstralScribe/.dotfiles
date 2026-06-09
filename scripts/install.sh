#!/usr/bin/env bash

set -euo pipefail

SCRIPT_PATH="$(pwd)/scripts"
DRY_RUN=false

source "$SCRIPT_PATH/helpers.sh"

run_stage() {
  local stage_name="$1"
  local stage_path="$2"

  log "install" "${CYAN}" "Running setup stage: $stage_name"
  if [[ "$DRY_RUN" == true ]]; then
    run "install" "$CYAN" "$DRY_RUN" bash "$stage_path" --dry-run
  else
    run "install" "$BLUE" "$DRY_RUN" bash "$stage_path"
  fi
}

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
  log "install" "$YELLOW" "DRY RUN enabled; no changes will be applied"
else
  sudo -v
fi

if ! command -v gum >/dev/null 2>&1; then
  echo "Error: gum is required to run this installer." >&2
  echo "Install gum first: https://github.com/charmbracelet/gum" >&2
  exit 1
fi

if ! command -v toilet >/dev/null 2>&1; then
  echo "Error: toilet is required to run this installer." >&2
  echo "Install toilet first: sudo pacman -S toilet" >&2
  exit 1
fi

printf "%s\n\n" "$(log "pre-setup" "$BLUE" "Doing Pre-Install setup")"
mkdir -p "$TEMP_PATH"
show_progress 1 4 "Created cache directory"
git clone -q --depth=1 https://github.com/xero/figlet-fonts.git "$TEMP_PATH/figlet-fonts"
show_progress 2 4 "Downloaded figlet fonts"
sudo mkdir -p /usr/share/toilet/fonts
show_progress 3 4 "Prepared toilet fonts directory"
sudo cp -r "$TEMP_PATH/figlet-fonts" /usr/share/toilet/fonts
show_progress 4 4 "Installed figlet fonts"

printf "\n%s\n\n\n" "$(log "pre-setup" "$BLUE" "Pre-Setup completed.")"
toilet "Arch Setup" --font "ANSI Regular" -d /usr/share/toilet/fonts

if gum confirm "Run Installation setup?"; then
  run_stage "pacman" "$SCRIPT_PATH/system/pacman.sh"
  run_stage "packages" "$SCRIPT_PATH/package.sh"
  run_stage "login" "$SCRIPT_PATH/system/login.sh"
  run_stage "services" "$SCRIPT_PATH/system/services.sh"
else
  log "install" "$YELLOW" "Skipping Installation."
fi

log "install" "$GREEN" "Installation completed"

if gum confirm "Apply configurations?"; then
  run_stage "configure" "$SCRIPT_PATH/configure.sh"
else
  log "configure" "$YELLOW" "Skipping configurations"
fi

run "post-setup" "$BLUE" "Cleaning up temp directory"
rm -rf "$TEMP_PATH"
