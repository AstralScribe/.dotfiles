#!/usr/bin/env zsh

# Colors
# shellcheck disable=SC2034
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
NEON="\e[96m"

END="\e[0m"


TEMP_PATH="$HOME/.cache/myde/temp"

log() {
  local log_name="$1"
  local color="$2"
  local message="$3"
  printf "%b\n" "${color}[${log_name}]${END} ${message}"
}

run() {
  local log_name="$1"
  local color="$2"
  local dry_run="$3"
  shift 3

  if [[ "${dry_run}" == true ]]; then
    log "${log_name}" "${color}" "DRY RUN: $*"
  else
    log "${log_name}" "${color}" "Running: $*"
    "$@"
  fi
}

show_progress() {
  local bar
  local message

  local current="$1"
  local total="$2"
  local width=20
  local filled=$((current * width / total))
  local empty=$((width - filled))


  printf -v bar '%*s' "${filled}" ''
  bar="${bar// /#}"
  message=$(log "pre-setup" "${BLUE}" "$3")

  printf -v empty_bar '%*s' "${empty}" ''
  gum style --foreground 212 "[${bar}${empty_bar// /-}] ${current}/${total} ${message}"
}

pkg_available() {
  pacman -Si "$1" &>/dev/null
}

pkg_status() {
  pacman -Qi "$1" &>/dev/null
}
