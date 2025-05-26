import os
import re
import subprocess
from typing import List, Optional
from dataclasses import dataclass

import parameters

@dataclass
class Packages:
    src_path: str
    dst_path: str
    is_symlink: bool = False
    is_directory: bool = False

if not os.path.exists(parameters.CLONE_DIR):
    os.makedirs(parameters.CLONE_DIR, exist_ok=True)
    with open(f"{parameters.CLONE_DIR}/.directory", "w") as file:
        file.write("[Desktop Entry]\nIcon=default-folder-git")
    print(f"Cloning directory created at {parameters.CLONE_DIR}")


def run(commands: List| str, output: Optional[str]=None, check:bool=True, **kwargs) -> subprocess.CompletedProcess:
    if output == "null":
        out = subprocess.run(commands, check=check, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, **kwargs)
    elif output == "pipe_out":
        out = subprocess.run(commands, check=check, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, **kwargs)
    elif output == "pipe":
        out = subprocess.run(commands, check=check, capture_output=True, **kwargs)
    else:
        out = subprocess.run(commands, check=check, **kwargs)
    return out


def pkg_status(pkg: str) -> bool:
    commands = ["pacman", "-Qi", pkg]
    try:
        run(commands,"null")
        return True
    except subprocess.CalledProcessError:
        return False


def pkg_available(pkg: str) -> bool:
    commands = ["pacman", "-Si", pkg]
    try:
        run(commands,"null")
        return True
    except subprocess.CalledProcessError:
        return False


def aur_available(pkg: str) -> bool:
    commands = [parameters.AUR, "-Si", pkg]
    try:
        run(commands,"null")
        return True
    except subprocess.CalledProcessError:
        return False


def nvidia_detect(mode=None):
    commands = ["lspci", "-k"] 
    result = run(commands, check=False, output="pipe", text=True)
    pattern = re.compile(r"(VGA|3D)")
    dGPU = [line.split(":")[-1] for line in result.stdout.splitlines() if pattern.search(line)]

    if mode == "verbose":
        for indx, gpu in enumerate(dGPU):
            print(f"\033[0;32m[gpu{indx}]\033[0m detected // {gpu}")
        return True

    if mode == "drivers":
        command = "cat /usr/lib/modules/*/pkgbase"
        out = run(command, check=False, shell=True, output="pipe", text=True)
        krnl = out.stdout.strip()
        
        pkgs = ["nvidia-utils", "nvidia-container-toolkit"]

        if krnl == "linux": 
            pkgs.append("nvidia")
        elif krnl == "linux-lts": 
            pkgs.append("nvidia-lts")
        else: 
            pkgs.append("nvidia-dkms")

        return pkgs

    if any("nvidia" in gpu.lower() for gpu in dGPU):
        return True
    else:
        return False


if __name__ == "__main__":
    print(f"Package status for linux: {pkg_status('linux')}")
    print(f"Package status for linux-lts: {pkg_status('linux-lts')}")
    print(f"Is package linux available? {pkg_available('linux')}")
    print(f"Is aur swww available? {aur_available('swww')}")
    nvidia_detect("verbose")
    nvidia_detect("drivers")
