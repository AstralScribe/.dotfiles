import os
import sys
import subprocess
from typing import List

import helpers
import parameters

#----------------#
# Installing AUR #
#----------------#
if helpers.pkg_status(parameters.AUR):
    print(f"{parameters.AUR} already installed...")
else:
    if helpers.pkg_status("git"):
        aur_path = f"{parameters.CLONE_DIR}/{parameters.AUR}"
        aur_url = f"https://aur.archlinux.org/{parameters.AUR}.git"
        commands = ['git', 'clone', aur_url, aur_path]
        helpers.run(commands, output="null")
        os.chdir(f"{parameters.CLONE_DIR}/{parameters.AUR}")
        try:
            command = "makepkg -si"
            out = helpers.run(command, shell=True)
            status = True
        except subprocess.CalledProcessError:
            status = False

        if status:
            print(f"{parameters.AUR} aur helper installed...")
        else:
            print(f"{parameters.AUR} aur helper not installed...")
    else:
        print("Git not installed.")
        sys.exit()

        
def _extract_repo(pkg):
    command = f"pacman -Si {pkg} | awk -F ': ' '/Repository / {{print $2}}'"
    out = helpers.run(command, text=True, output="pipe", shell=True)
    return out.stdout.strip()


def split_pkg(pkgs: List):
    pacman_pkgs = []
    aur_pkgs = []
    for pkg in pkgs:
        if helpers.pkg_status(pkg): 
            print(f"\033[0;33m[skip]\033[0m {pkg} is already installed...")
        elif helpers.pkg_available(pkg):
            repo = _extract_repo(pkg)
            print(f"\033[0;32m[{repo}]\033[0m queueing {pkg} from official arch repo...")
            pacman_pkgs.append(pkg)
        elif helpers.aur_available(pkg):
            print(f"\033[0;34m[aur]\033[0m queueing {pkg} from arch user repo...")
            aur_pkgs.append(pkg)
        else:
            print(f"Error: unknown package {pkg}...")

    return pacman_pkgs, aur_pkgs


def install_pacman(pkgs: List):
    pkgs_to_install = " ".join(pkgs)
    commands = ["sudo", "pacman", "-S", pkgs_to_install]
    helpers.run(commands, output="pipe")


def install_aur(pkgs: List):
    pkgs_to_install = " ".join(pkgs)
    commands = [parameters.AUR, "-S", pkgs_to_install]
    helpers.run(commands, output="pipe")


def install_eww():

