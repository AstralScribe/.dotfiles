import os
import shutil
import sys
import subprocess
from typing import List, Union

import helpers
import parameters

#----------------#
# Installing AUR #
#----------------#
def install_aur_helper():
    if helpers.pkg_status(parameters.AUR):
        print(f"{parameters.AUR} already installed...")
        return 
    if not helpers.pkg_status("git"):
        print("Git not installed.")
        sys.exit()

    aur_path = f"{parameters.CLONE_DIR}/{parameters.AUR}"
    aur_url = f"https://aur.archlinux.org/{parameters.AUR}.git"
    commands = ['git', 'clone', aur_url, aur_path]
    helpers.run(commands, output="null")
    os.chdir(f"{parameters.CLONE_DIR}/{parameters.AUR}")
    try:
        command = "makepkg -si"
        helpers.run(command, shell=True)
        status = True
    except subprocess.CalledProcessError:
        status = False

    if status:
        print(f"{parameters.AUR} aur helper installed...")
    else:
        print(f"{parameters.AUR} aur helper not installed...")

        
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


def install_pacman(pkgs: Union[List, str]):
    if isinstance(pkgs, List):
        pkgs_to_install = " ".join(pkgs)
    elif isinstance(pkgs, str):
        pkgs_to_install = pkgs
    else:
        print(f"Error: unknown package {pkgs_to_install}...")
        return

    commands = ["sudo", "pacman", "-Sy", pkgs_to_install]
    helpers.run(commands)


def post_pacman_install_setup():
    if helpers.pkg_status("rustup"):
        commands = ["rustup", "install", "stable"]
        helpers.run(commands)


def install_aur(pkgs: List):
    pkgs_to_install = " ".join(pkgs)
    commands = [parameters.AUR, "-Sy", pkgs_to_install]
    helpers.run(commands)


def install_eww():
    src_install_path = "./target/release/eww"
    os.chdir("../source/eww")
    if not helpers.pkg_available("rustup"):
        return "Rust not installed. Cancelling."
    
    print("\033[0;34m[custom]\033[0m Installing eww from submodule...")

    commands = ['cargo', 'build', '--release', '--no-default-features', '--features=wayland']
    helpers.run(commands)
    target_path = "../../configs/.config/myde/custScripts/eww"
    print(f"\033[0;32m[Moving]\033[0m Eww: {src_install_path} ---> {target_path}")
    shutil.move(src_install_path, target_path)
    helpers.run(["rm", "-rf", "./target"])

    # commands = ['cargo', 'build', '--release', '--no-default-features', '--features=x11']
    # helpers.run(commands)
    # target_path = "../../configs/.config/myde/custScripts/eww-x11"
    # print(f"\033[0;32m[Moving]\033[0m Eww: {src_install_path} ---> {target_path}")
    # shutil.move(src_install_path, target_path)
