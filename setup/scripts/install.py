#!/usr/bin/python3

import helpers
import install_pre
import packages
import install_pkg
import install_fnt

print("""
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
""")


#------------------#
# evaluate options #
#------------------#
flg_Install=0
flg_Configure=0
flg_Service=0


# while getopts idrs RunStep; do
#     case $RunStep in
#         i)  flg_Install=1 ;;
#         d)  flg_Install=1 ; export use_default="--noconfirm" ;;
#         r)  flg_Configure=1 ;;
#         s)  flg_Service=1 ;;
#         *)  echo "...valid options are..."
#             echo "i : [i]nstall hyprland without configs"
#             echo "d : install hyprland [d]efaults without configs --noconfirm"
#             echo "r : [r]estore config files"
#             echo "s : enable system [s]ervices"
#             exit 1 ;;
#     esac
# done
#
# if [ $OPTIND -eq 1 ]; then
#     flg_Install=1
#     flg_Configure=1
#     flg_Service=1
# fi

flg_Install=1
flg_Configure=1
flg_Service=1


#--------------------#
# pre-install script #
#--------------------#
print("""
  ____                ___           _        _ _   ____       _
 |  _ \ _ __ ___     |_ _|_ __  ___| |_ __ _| | | / ___|  ___| |_ _   _ _ __
 | |_) | '__/ _ \_____| || '_ \/ __| __/ _` | | | \___ \ / _ \ __| | | | '_ \
 |  __/| | |  __/_____| || | | \__ \ || (_| | | |  ___) |  __/ |_| |_| | |_) |
 |_|   |_|  \___|    |___|_| |_|___/\__\__,_|_|_| |____/ \___|\__|\__,_| .__/
                                                                       |_|
""")


install_pre.boot()
install_pre.pacman()
install_pre.user_vars()


#--------------------------------#
# intstalling necessary packages #
#--------------------------------#
if flg_Install:
    print("""
 ___           _        _ _ _               ____  _
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  _ \| | ____ _ ___
 | || '_ \/ __| __/ _` | | | | '_ \ / _` | | |_) | |/ / _` / __|
 | || | | \__ \ || (_| | | | | | | | (_| | |  __/|   < (_| \__ \
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |_|   |_|\_\__, |___/
                                    |___/             |___/

""")

    #----------------------#
    # prepare package list #
    #----------------------#
    pkgs = []
    if helpers.nvidia_detect():
        command = "cat /usr/lib/modules/*/pkgbase"
        out = helpers.run(command, check=False, shell=True, output="pipe", text=True)
        krnl = out.stdout.splitlines()[0]
        pkgs.append(f"{krnl}-headers")
        pkgs.extend(helpers.nvidia_detect("drivers"))
        helpers.nvidia_detect("verbose")

    pkgs.extend(packages.packages)

    #--------------------------------#
    # install packages from the list #
    #--------------------------------#
    pacman_pkgs, aur_pkgs = install_pkg.split_pkg(pkgs)
    install_pkg.install_pacman(pacman_pkgs)
    install_pkg.install_aur(aur_pkgs)
    del pkgs, pacman_pkgs, aur_pkgs
        
    #--------------------------------#
    # installing fonts from the list #
    #--------------------------------#
    install_fnt.install()


#-------------------#
# Configuring setup #
#-------------------#
if flg_Configure:
    print("""
  ____             __ _                  _                   _       _
 / ___|___  _ __  / _(_) __ _ _   _ _ __(_)_ __   __ _    __| | ___ | |_ ___
| |   / _ \| '_ \| |_| |/ _` | | | | '__| | '_ \ / _` |  / _` |/ _ \| __/ __|
| |__| (_) | | | |  _| | (_| | |_| | |  | | | | | (_| | | (_| | (_) | |_\__ \
 \____\___/|_| |_|_| |_|\__, |\__,_|_|  |_|_| |_|\__, |  \__,_|\___/ \__|___/
                        |___/                    |___/
""")

#     "${scrDir}/restore_cfg.sh"
#     echo -e "\n\033[0;32m[themepatcher]\033[0m Patching themes..."
#     while IFS='"' read -r null1 themeName null2 themeRepo
#     do
#         themeNameQ+=("${themeName//\"/}")
#         themeRepoQ+=("${themeRepo//\"/}")
#         themePath="${confDir}/hyde/themes/${themeName}"
#         [ -d "${themePath}" ] || mkdir -p "${themePath}"
#         [ -f "${themePath}/.sort" ] || echo "${#themeNameQ[@]}" > "${themePath}/.sort"
#     done < "${scrDir}/themepatcher.lst"
#     parallel --bar --link "${scrDir}/themepatcher.sh" "{1}" "{2}" "{3}" "{4}" ::: "${themeNameQ[@]}" ::: "${themeRepoQ[@]}" ::: "--skipcaching" ::: "false"
#     echo -e "\n\033[0;32m[cache]\033[0m generating cache files..."
#     "$HOME/.local/share/bin/swwwallcache.sh" -t ""
#     if printenv HYPRLAND_INSTANCE_SIGNATURE &> /dev/null; then
#         "$HOME/.local/share/bin/themeswitch.sh" &> /dev/null
