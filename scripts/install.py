#!/usr/bin/python3
import argparse
import sys

import helpers
import install_pkg
import install_pre
import packages
import configure

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
        # pkgs.extend(helpers.nvidia_detect("drivers"))
        helpers.nvidia_detect("verbose")

    pkgs.extend(packages.packages)

    #--------------------------------#
    # install packages from the list #
    #--------------------------------#
    if not helpers.pkg_status("rustup"):
        install_pkg.install_rust()
    install_pkg.install_aur_helper()
    pacman_pkgs, aur_pkgs = install_pkg.split_pkg(pkgs)

    print("Pacman Packages: ", pacman_pkgs)
    print("AUR Packages: ", aur_pkgs)

    continue_setup = input("Do you wish to continue? [Y/n]")
    
    if continue_setup.lower() == "y":
        install_pkg.install_pacman(pacman_pkgs)
        install_pkg.install_aur(aur_pkgs)
        # install_pkg.install_eww()
        del pkgs, pacman_pkgs, aur_pkgs
    else:
        sys.exit()
        
    #---------------------------------------#
    # installing custom fonts from the list #
    #---------------------------------------#
    # install_fnt.install()

    #-----------------------------------------#
    # installing shell plugings from the list #
    #-----------------------------------------#
    # plugins_sh.install()

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
    configure.configure()
    configure.patch_themes()


