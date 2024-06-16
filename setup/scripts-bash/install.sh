#!/usr/bin/env bash
#|------------------------|#
#|Main Installation script|#
#|Mayank Sinha            |#
#|------------------------|#

cat << "EOF"

|---------------------------------------------------------------------|
       .             _             _       ____       _
      / \           / \   _ __ ___| |__   / ___|  ___| |_ _   _ _ __
     /^  \         / _ \ | '__/ __| '_ \  \___ \ / _ \ __| | | | '_ \
    /  _  \       / ___ \| | | (__| | | |  ___) |  __/ |_| |_| | |_) |
   /  | | ~\     /_/   \_\_|  \___|_| |_| |____/ \___|\__|\__,_| .__/
  /.-'   '-.\                                                  |_|
|---------------------------------------------------------------------|
|                            Arch Linux Setup                         |
|---------------------------------------------------------------------|

EOF

#--------------------------------#
# import variables and functions #
#--------------------------------#
scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

#------------------#
# evaluate options #
#------------------#
flg_Install=0
flg_Configure=0
flg_Service=0

while getopts idrs RunStep; do
    case $RunStep in
        i)  flg_Install=1 ;;
        d)  flg_Install=1 ; export use_default="--noconfirm" ;;
        r)  flg_Configure=1 ;;
        s)  flg_Service=1 ;;
        *)  echo "...valid options are..."
            echo "i : [i]nstall hyprland without configs"
            echo "d : install hyprland [d]efaults without configs --noconfirm"
            echo "r : [r]estore config files"
            echo "s : enable system [s]ervices"
            exit 1 ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    flg_Install=1
    flg_Configure=1
    flg_Service=1
fi

#--------------------#
# pre-install script #
#--------------------#
if [ ${flg_Install} -eq 1 ] && [ ${flg_Configure} -eq 1 ]; then
    cat << "EOF"

 ____                ___           _        _ _   ____       _
|  _ \ _ __ ___     |_ _|_ __  ___| |_ __ _| | | / ___|  ___| |_ _   _ _ __
| |_) | '__/ _ \_____| || '_ \/ __| __/ _` | | | \___ \ / _ \ __| | | | '_ \
|  __/| | |  __/_____| || | | \__ \ || (_| | | |  ___) |  __/ |_| |_| | |_) |
|_|   |_|  \___|    |___|_| |_|___/\__\__,_|_|_| |____/ \___|\__|\__,_| .__/
                                                                      |_|

EOF

    "${scrDir}/install_pre.sh"
fi


#--------------------------------#
# intstalling necessary packages #
#--------------------------------#
if [ ${flg_Install} -eq 1 ]; then
    cat << "EOF"

 ___           _        _ _ _               ____  _
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  _ \| | ____ _ ___
 | || '_ \/ __| __/ _` | | | | '_ \ / _` | | |_) | |/ / _` / __|
 | || | | \__ \ || (_| | | | | | | | (_| | |  __/|   < (_| \__ \
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |_|   |_|\_\__, |___/
                                    |___/             |___/

EOF

    #----------------------#
    # prepare package list #
    #----------------------#
    shift $((OPTIND - 1))
    cust_pkg=$1
    cp "${scrDir}/custom_hypr.lst" "${scrDir}/install_pkg.lst"

    if [ -f "${cust_pkg}" ] && [ ! -z "${cust_pkg}" ]; then
        cat "${cust_pkg}" >> "${scrDir}/install_pkg.lst"
    fi

    #--------------------------------#
    # add nvidia drivers to the list #
    #--------------------------------#
    if nvidia_detect; then
        cat /usr/lib/modules/*/pkgbase | while read krnl; do
            echo "${krnl}-headers" >> "${scrDir}/install_pkg.lst"
        done
        nvidia_detect --drivers >> "${scrDir}/install_pkg.lst"
    fi
    nvidia_detect --verbose

    #--------------------------------#
    # install packages from the list #
    #--------------------------------#
    "${scrDir}/install_pkg.sh" "${scrDir}/install_pkg.lst"
    rm "${scrDir}/install_pkg.lst"


    #--------------------------------#
    # installing fonts from the list #
    #--------------------------------#
    "${scrDir}/install_fnt.sh"
fi




#-------------------#
# Configuring setup #
#-------------------#
if [ ${flg_Configure} -eq 1 ]; then
    cat << "EOF"

  ____             __ _                  _                   _       _
 / ___|___  _ __  / _(_) __ _ _   _ _ __(_)_ __   __ _    __| | ___ | |_ ___
| |   / _ \| '_ \| |_| |/ _` | | | | '__| | '_ \ / _` |  / _` |/ _ \| __/ __|
| |__| (_) | | | |  _| | (_| | |_| | |  | | | | | (_| | | (_| | (_) | |_\__ \
 \____\___/|_| |_|_| |_|\__, |\__,_|_|  |_|_| |_|\__, |  \__,_|\___/ \__|___/
                        |___/                    |___/

EOF

    "${scrDir}/restore_cfg.sh"
    echo -e "\n\033[0;32m[themepatcher]\033[0m Patching themes..."
    while IFS='"' read -r null1 themeName null2 themeRepo
    do
        themeNameQ+=("${themeName//\"/}")
        themeRepoQ+=("${themeRepo//\"/}")
        themePath="${confDir}/hyde/themes/${themeName}"
        [ -d "${themePath}" ] || mkdir -p "${themePath}"
        [ -f "${themePath}/.sort" ] || echo "${#themeNameQ[@]}" > "${themePath}/.sort"
    done < "${scrDir}/themepatcher.lst"
    parallel --bar --link "${scrDir}/themepatcher.sh" "{1}" "{2}" "{3}" "{4}" ::: "${themeNameQ[@]}" ::: "${themeRepoQ[@]}" ::: "--skipcaching" ::: "false"
    echo -e "\n\033[0;32m[cache]\033[0m generating cache files..."
    "$HOME/.local/share/bin/swwwallcache.sh" -t ""
    if printenv HYPRLAND_INSTANCE_SIGNATURE &> /dev/null; then
        "$HOME/.local/share/bin/themeswitch.sh" &> /dev/null
    fi
fi


