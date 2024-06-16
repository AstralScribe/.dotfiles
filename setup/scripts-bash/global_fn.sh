#!/usr/bin/env bash
#|---/ /+------------------+---/ /|#
#|--/ /-| Global functions |--/ /-|#
#|-/ /--| Prasanth Rangan  |-/ /--|#
#|/ /---+------------------+/ /---|#

set -e

# Local params
scrDir="$(dirname "$(realpath "$0")")"
aurHelper="paru"
shell="zsh"

sysConfDir="$HOME/.config"
customConfDir="$scrDir/../configs/"
cacheDir="$HOME/.cache/myde"
cloneDir="$cacheDir/clone"

if [ ! -d "$cloneDir" ]; then
    mkdir -p "$cloneDir"
    echo -e "[Desktop Entry]\nIcon=default-folder-git" > "$cloneDir/.directory"
    echo "~/Clone directory created..."
fi

pkg_installed() {
    local PkgIn=$1

    if pacman -Qi "${PkgIn}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

chk_list() {
    vrType="$1"
    local inList=("${@:2}")
    for pkg in "${inList[@]}"; do
        if pkg_installed "${pkg}"; then
            printf -v "${vrType}" "%s" "${pkg}"
            export "${vrType}"
            return 0
        fi
    done
    return 1
}

pkg_available() {
    local PkgIn=$1

    if pacman -Si "${PkgIn}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

aur_available() {
    local PkgIn=$1

    if ${aurHelper} -Si "${PkgIn}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

nvidia_detect() {
    readarray -t dGPU < <(lspci -k | grep -E "(VGA|3D)" | awk -F ': ' '{print $NF}')
    if [ "${1}" == "--verbose" ]; then
        for indx in "${!dGPU[@]}"; do
            echo -e "\033[0;32m[gpu$indx]\033[0m detected // ${dGPU[indx]}"
        done
        return 0
    fi
    if [ "${1}" == "--drivers" ]; then
        krnl=$(cat /usr/lib/modules/*/pkgbase)
        if [ "$krnl" == "linux" ]; then
            echo -e "nvidia\nnvidia-utils"
        elif [ "$krnl" == "linux-lts" ]; then
            echo -e "nvidia-lts\nnvidia-utils"
        else
            echo -e "nvidia-dkms\nnvidia-utils"
        fi
        return 0
    fi
    if grep -iq nvidia <<< "${dGPU[@]}"; then
        return 0
    else
        return 1
    fi
}

prompt_timer() {
    set +e
    unset promptIn
    local timsec=$1
    local msg=$2
    while [[ ${timsec} -ge 0 ]]; do
        echo -ne "\r :: ${msg} (${timsec}s) : "
        read -t 1 -n 1 promptIn
        [ $? -eq 0 ] && break
        ((timsec--))
    done
    export promptIn
    echo ""
    set -e
}


