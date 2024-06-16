#!/usr/bin/env bash
#|---/ /+----------------------------------------+---/ /|#
#|--/ /-| Script to install pkgs from input list |--/ /-|#
#|-/ /--| Prasanth Rangan                        |-/ /--|#
#|/ /---+----------------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

#----------------#
# Installing AUR #
#----------------#
if pkg_installed $aurHelper; then
    echo "$aurHelper already installed..."
else
    if pkg_installed git; then
        git clone "https://aur.archlinux.org/${aurHelper}.git" "$cloneDir/${aurHelper}"
    else
        echo "git dependency is not installed..."
        exit 1
    fi

    cd "$cloneDir/$aurHelper"
    makepkg ${use_default} -si

    if [ $? -eq 0 ]; then
        echo "${aurHelper} aur helper installed..."
        exit 0
    else
        echo "${aurHelper} installation failed..."
        exit 1
    fi
fi

listPkg="${1:-"${scrDir}/custom_hypr.lst"}"
archPkg=()
aurhPkg=()
ofs=$IFS
IFS='|'

while read -r pkg deps; do
    pkg="${pkg// /}"
    if [ -z "${pkg}" ]; then
        continue
    fi

    # Need to spend more time to understand this part #
    if [ ! -z "${deps}" ]; then
        deps="${deps%"${deps##*[![:space:]]}"}"
        while read -r cdep; do
            echo -e "$cdep"
            pass=$(cut -d '#' -f 1 "${listPkg}" | awk -F '|' -v chk="${cdep}" '{if($1 == chk) {print 1;exit}}')
            if [ -z "${pass}" ]; then
                if pkg_installed "${cdep}"; then
                    pass=1
                else
                    break
                fi
            fi
        done < <(echo "${deps}" | xargs -n1)

        if [[ ${pass} -ne 1 ]]; then
            echo -e "\033[0;33m[skip]\033[0m ${pkg} is missing (${deps}) dependency..."
            continue
        fi
    fi
    # Need to spend more time to understand this part #

    if pkg_installed "${pkg}"; then
        echo -e "\033[0;33m[skip]\033[0m ${pkg} is already installed..."
    elif pkg_available "${pkg}"; then
        repo=$(pacman -Si "${pkg}" | awk -F ': ' '/Repository / {print $2}')
        echo -e "\033[0;32m[${repo}]\033[0m queueing ${pkg} from official arch repo..."
        archPkg+=("${pkg}")
    elif aur_available "${pkg}"; then
        echo -e "\033[0;34m[aur]\033[0m queueing ${pkg} from arch user repo..."
        aurhPkg+=("${pkg}")
    else
        echo "Error: unknown package ${pkg}..."
    fi
done < <(cut -d '#' -f 1 "${listPkg}")

IFS=${ofs}

if [[ ${#archPkg[@]} -gt 0 ]]; then
    sudo pacman ${use_default} -S "${archPkg[@]}"
fi

if [[ ${#aurhPkg[@]} -gt 0 ]]; then
    "${aurHelper}" ${use_default} -S "${aurhPkg[@]}"
fi
