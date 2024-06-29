import os
import helpers


def pacman():
    pacman_path = "/etc/pacman.conf"
    bkp_path = "/etc/pacman.conf.bkp"
    if os.path.exists(pacman_path) and not os.path.exists(bkp_path):
        print("\033[0;32m[PACMAN]\033[0m Configuring pacman to increase download load and spicing it...")
        helpers.run(["sudo", "cp", pacman_path, bkp_path], output="null")

        sed_command_increase_download = r"""
/^#Color/c\Color
/^#VerbosePkgLists/c\VerbosePkgLists
/^#ParallelDownloads/c\ParallelDownloads = 10"""
        sed_command_add_multilib = r"/^#\[multilib\]/,+1 s/^#//"

        helpers.run(["sudo", "sed", "-i", sed_command_increase_download, pacman_path], output="null")
        helpers.run(["sudo", "sed", "-i", sed_command_add_multilib, pacman_path], output="null")
        helpers.run("sudo pacman -Syyu", shell=True)
        helpers.run("sudo pacman -Fy", shell=True)
    else:
        print("\033[0;33m[SKIP]\033[0m pacman is already configured...")
    

def user_vars():
    file ="/etc/profile.d/user_vars.sh"
    if not os.path.exists(file):
        print("\033[0;32m[USER VARS]\033[0m adding global variables and path to the profile.d...")
        commands = ["sudo", "cp" "user_vars.sh", file]
        helpers.run(commands, output="null")
    else:
        print("\033[0;33m[SKIP]\033[0m user_vars.sh already present...")
