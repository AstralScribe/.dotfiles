#!/usr/bin/env bash

set -eou pipefail

SCRIPT_PATH="$(pwd)/scripts"
PACKAGES_PATH="${SCRIPT_PATH}/packages"
DRY_RUN=false

source "${SCRIPT_PATH}/helpers.sh"
source "${PACKAGES_PATH}/nvidia.sh"

run_post_install_script() {
  local script_path="$1"
  local script_name
  script_name="$(basename "${script_path}")"

  log "packages" "${CYAN}" "Running post-install script: ${script_name}"
  if [[ "${DRY_RUN}" == true ]]; then
    run "packages" "${CYAN}" "${DRY_RUN}" bash "${script_path}" --dry-run
  else
    run "packages" "${CYAN}" "${DRY_RUN}" bash "${script_path}"
  fi
}

get_list_files() {
  shopt -s nullglob
  local files=("${PACKAGES_PATH}/lists"/*.list)
  shopt -u nullglob

  if (( ${#files[@]} == 0 )); then
    log "packages" "${RED}" "No package list files found in ${PACKAGES_PATH}"
    exit 1
  fi

  printf '%s\n' "${files[@]}"
}

select_list_file() {
  mapfile -t list_files < <(get_list_files)

  local options=("all")
  local file
  for file in "${list_files[@]}"; do
    options+=("$(basename "${file}")")
  done

  printf '%s\n' "${options[@]}" | gum choose --header "Select package list to install"
}

install_packages_from_file() {
  local list_file="$1"

  log "packages" "${CYAN}" "Processing $(basename "${list_file}")"

  while IFS= read -r package || [[ -n "${package}" ]]; do
    package="${package%%#*}"
    package="$(xargs <<<"${package}")"

    if [[ -z "${package}" ]]; then
      continue
    fi

    if [[ -n "${SEEN_PACKAGES[${package}]:-}" ]]; then
      log "packages" "${YELLOW}" "Skipping ${package} (duplicate entry)"
      continue
    fi

    SEEN_PACKAGES["${package}"]=1

    if pkg_status "${package}"; then
      log "packages" "${YELLOW}" "Skipping ${package} (already installed)"
      continue
    fi

    log "packages" "${GREEN}" "Installing ${package}"
    run "packages" "${CYAN}" "${DRY_RUN}" sudo pacman -S --noconfirm "${package}"
  done < "${list_file}"
}

install_nvidia_packages() {
  local package

  if ! nvidia_detect; then
    log "packages" "${YELLOW}" "No NVIDIA GPU detected; skipping NVIDIA packages"
    return
  fi

  log "packages" "${CYAN}" "NVIDIA GPU detected; checking related packages"

  while IFS= read -r package || [[ -n "${package}" ]]; do
    if [[ -z "${package}" ]]; then
      continue
    fi

    if [[ -n "${SEEN_PACKAGES[${package}]:-}" ]]; then
      log "packages" "${YELLOW}" "Skipping ${package} (duplicate entry)"
      continue
    fi

    SEEN_PACKAGES["${package}"]=1

    if pkg_status "${package}"; then
      log "packages" "${YELLOW}" "Skipping ${package} (already installed)"
      continue
    fi

    log "packages" "${GREEN}" "Installing ${package}"
    run "packages" "${CYAN}" "${DRY_RUN}" sudo pacman -S --noconfirm "${package}"
  done < <(nvidia_detect drivers)
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

declare -gA SEEN_PACKAGES=()

selected="$(select_list_file)"

if [[ "${selected}" == "all" ]]; then
  mapfile -t selected_files < <(get_list_files)
else
  selected_files=("${PACKAGES_PATH}/${selected}")
fi

if [[ "${DRY_RUN}" == true ]]; then
  log "packages" "${CYAN}" "DRY RUN: Skipping package updates"
else
  log "packages" "${CYAN}" "Updating: packages"
  sudo pacman -Syyu
fi


for file in "${selected_files[@]}"; do
  install_packages_from_file "${file}"
done

install_nvidia_packages

run_post_install_script "${PACKAGES_PATH}/rust.sh"
run_post_install_script "${PACKAGES_PATH}/eww.sh"

log "packages" "${CYAN}" "Done"
