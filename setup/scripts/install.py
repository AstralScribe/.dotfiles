#!/usr/bin/python3
import argparse

import helpers
import install_fnt
import install_pkg
import install_pre
import packages

print(r"""
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
parser = argparse.ArgumentParser(description='Process some flags.')
parser.add_argument('-i', action='store_true', help='Install hyprland without configs')
parser.add_argument('-r', action='store_true', help='Restore config files')
parser.add_argument('-s', action='store_true', help='Enable system services')

args = parser.parse_args()

flg_Install = 0
flg_Configure = 0
flg_Service = 0

if args.i:
    flg_Install = 1
if args.r:
    flg_Configure = 1
if args.s:
    flg_Service = 1

if not (args.i or args.r or args.s):
    flg_Install = 1
    flg_Configure = 1
    flg_Service = 1

print(f"Install flag: {flg_Install}")
print(f"Configure flag: {flg_Configure}")
print(f"Service flag: {flg_Service}")

#--------------------#
# pre-install script #
#--------------------#
print(r"""
  ____                ___           _        _ _   ____       _
 |  _ \ _ __ ___     |_ _|_ __  ___| |_ __ _| | | / ___|  ___| |_ _   _ _ __
 | |_) | '__/ _ \_____| || '_ \/ __| __/ _` | | | \___ \ / _ \ __| | | | '_ \
 |  __/| | |  __/_____| || | | \__ \ || (_| | | |  ___) |  __/ |_| |_| | |_) |
 |_|   |_|  \___|    |___|_| |_|___/\__\__,_|_|_| |____/ \___|\__|\__,_| .__/
                                                                       |_|
""")


# install_pre.boot()
install_pre.pacman()
install_pre.user_vars()


#--------------------------------#
# intstalling necessary packages #
#--------------------------------#
if flg_Install:
    print(r"""
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
        krnl = out.stdout.strip()
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
    print(r"""
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
