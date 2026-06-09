#!/usr/bin/env bash

set -eou pipefail

SCRIPT_PATH="$(pwd)/scripts"
source "${SCRIPT_PATH}/helpers.sh"


nvidia_detect() {
    local mode="${1:-}"
    local gpus=()

    while IFS= read -r line; do
        if [[ "$line" =~ (VGA|3D) ]]; then
            gpus+=("${line##*:}")
        fi
    done < <(lspci -k)

    if [[ "$mode" == "verbose" ]]; then
        local index=0

        for gpu in "${gpus[@]}"; do
            printf "${BLUE}[gpu%s]${END} detected // %s\n" "$index" "$gpu"
            index=$((index + 1))
        done

        return 0
    fi

    if [[ "$mode" == "drivers" ]]; then
        local kernel
        local pkgs=("nvidia-utils" "nvidia-container-toolkit" "nvidia-settings")

        kernel="$(cat /usr/lib/modules/*/pkgbase 2>/dev/null | head -n 1)"

        if [[ "$kernel" == "linux" ]]; then
            pkgs+=("nvidia")
        elif [[ "$kernel" == "linux-lts" ]]; then
            pkgs+=("nvidia-open-lts")
        else
            pkgs+=("nvidia-dkms")
        fi

        printf '%s\n' "${pkgs[@]}"
        return 0
    fi

    for gpu in "${gpus[@]}"; do
        if [[ "${gpu,,}" == *"nvidia"* ]]; then
            return 0
        fi
    done

    return 1
}
