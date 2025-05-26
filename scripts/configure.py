import os

import helpers
import parameters

def configure():
    try:
        configs = {}
        with open(parameters.CONFIG_FILE, "r") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                parts = line.split('|')
                if len(parts) != 6:
                    print(f"\033[0;31m[Error]\033[0m Invalid format in line: {line}")
                    continue

                enabled, name, src_path, dst_path, is_directory, is_symlink = parts

                if enabled != '1':  # Skip disabled entries
                    continue

                configs[name] = {
                    "src_path": src_path,
                    "dst_path": dst_path,
                    "is_directory": is_directory.lower() == 'true',
                    "is_symlink": is_symlink.lower() == 'true'
                }
    except FileNotFoundError:
        print(f"\033[0;31m[Error]\033[0m Config file {parameters.CONFIG_FILE} not found.")
        return
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Error reading {parameters.CONFIG_FILE}: {str(e)}")
        return

    for name, config in configs.items():
        pkg = helpers.Packages(config)
        print(f"\033[0;34m[Symlink]\033[0m {pkg.is_symlink} \033[0;32m[Configuring]\033[0m {name} {pkg.dst_path} <-- {pkg.src_path}.")

        # Create parent directory if it doesn't exist
        parent_dir = os.path.dirname(pkg.dst_path)
        if not os.path.exists(parent_dir):
            try:
                os.makedirs(parent_dir, exist_ok=True)
                print(f"Created parent directory: {parent_dir}")
            except PermissionError:
                print(f"Permission denied when creating directory: {parent_dir}. Trying with sudo...")
                try:
                    helpers.run(["sudo", "mkdir", "-p", parent_dir])
                    print(f"Created parent directory with sudo: {parent_dir}")
                except Exception as e:
                    print(f"\033[0;31m[Error]\033[0m Failed to create directory {parent_dir}: {str(e)}")
                    continue

        if pkg.is_symlink:
            try:
                os.symlink(src=pkg.src_path, dst=pkg.dst_path, target_is_directory=pkg.is_directory)
                print(f"Created symlink: {pkg.dst_path}")
            except FileExistsError:
                print(f"File already exists: {pkg.dst_path}")
            except PermissionError:
                print(f"Permission denied when creating symlink: {pkg.dst_path}. Trying with sudo...")
                try:
                    helpers.run(["sudo", "ln", "-s", pkg.src_path, pkg.dst_path])
                    print(f"Created symlink with sudo: {pkg.dst_path}")
                except Exception as e:
                    print(f"\033[0;31m[Error]\033[0m Failed to create symlink {pkg.dst_path}: {str(e)}")
            except OSError as e:
                print(f"\033[0;31m[Error]\033[0m Failed to create symlink {pkg.dst_path}: {str(e)}")
        else:
            try:
                commands = ["cp", "-r", pkg.src_path, pkg.dst_path]
                helpers.run(commands)
                print(f"Copied: {pkg.dst_path}")
            except Exception as e:
                print(f"Permission denied or other error: {str(e)}. Trying as sudo...")
                try:
                    commands = ["sudo", "cp", "-r", pkg.src_path, pkg.dst_path]
                    helpers.run(commands)
                    print(f"Copied with sudo: {pkg.dst_path}")
                except Exception as e:
                    print(f"\033[0;31m[Error]\033[0m Failed to copy {pkg.dst_path}: {str(e)}")

    print("\033[0;34m[Git]\033[0m De-initialising the submodules.")
    try:
        helpers.run("git submodule deinit --all", shell=True)
        print("Successfully de-initialized git submodules.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to de-initialize git submodules: {str(e)}")

def patch_themes():
    ...


def configure_display_manager():
    print("\033[0;32m[DISPLAY MANAGER]\033[0m Configuring SDDM...")

    try:
        if not os.path.exists("/etc/sddm.conf.d"):
            helpers.run(["sudo", "mkdir", "-p", "/etc/sddm.conf.d"])
            print("\033[0;32m[DISPLAY MANAGER]\033[0m Created SDDM config directory.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to create SDDM config directory: {str(e)}")
        return

    try:
        helpers.run("sudo touch /etc/sddm.conf.d/kde_settings.conf", shell=True)
        print("\033[0;32m[DISPLAY MANAGER]\033[0m Created SDDM settings file.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to create SDDM settings file: {str(e)}")
        return

    try:
        helpers.run("sudo cp -r ~/.dotfiles/configs/sddm/Candy /usr/share/sddm/themes/Candy", shell=True)
        print("\033[0;32m[DISPLAYMANAGER]\033[0m Copied Candy theme to SDDM themes directory.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to copy Candy theme: {str(e)}")
        return

    try:
        helpers.run("sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.t2.bkp", shell=True)
        print("\033[0;32m[DISPLAYMANAGER]\033[0m Created backup of SDDM settings.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to create backup of SDDM settings: {str(e)}")
        # Continue even if backup fails

    try:
        helpers.run("sudo cp /usr/share/sddm/themes/Candy/kde_settings.conf /etc/sddm.conf.d/", shell=True)
        print("\033[0;32m[DISPLAYMANAGER]\033[0m Applied Candy theme settings to SDDM.")
    except Exception as e:
        print(f"\033[0;31m[Error]\033[0m Failed to apply Candy theme settings: {str(e)}")

if __name__ == "__main__":
    configure()
    configure_display_manager()
