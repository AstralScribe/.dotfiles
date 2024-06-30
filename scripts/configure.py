import os
import shutil
import yaml

import helpers


def configure():
    with open("./config.yaml", "r") as f:
        CONFIGS = yaml.safe_load(f)

    for name, config in CONFIGS.items():
        pkg = helpers.AttrDict(config)
        print(f"\033[0;34m[Symlink]\033[0m {pkg.is_symlink} \033[0;32m[Configuring]\033[0m {name} {pkg.dst_path} <-- {pkg.src_path}.")
        if pkg.is_symlink:
            os.symlink(src=pkg.src_path, dst=pkg.dst_path, target_is_directory=pkg.is_directory)
        else:
            try:
                shutil.copytree(src=pkg.src_path, dst=pkg.dst_path)
            except PermissionError:
                print("Permission denied. Trying as sudo...")
                commands = ["sudo", "cp", "-r", pkg.src_path, pkg.dst_path]
                helpers.run(commands)


    print("\033[0;34m[Git]\033[0m De-initialising the submodules.")
    helpers.run(["git", "submodules", "deinit", "--all"])

def patch_themes():
    ...


def configure_display_manager():
    if not os.path.exists("/etc/sddm.conf.d"):
        helpers.run(["sudo", "mkdir", "-p", "/etc/sddm.conf.d"])
        print("\033[0;32m[DISPLAYMANAGER]\033[0m configuring sddm...")

    helpers.run("sudo touch /etc/sddm.conf.d/kde_settings.conf", shell=True)
    helpers.run("sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.t2.bkp", shell=True)
    helpers.run("sudo cp /usr/share/sddm/themes/${sddmtheme}/kde_settings.conf /etc/sddm.conf.d/", shell=True)

