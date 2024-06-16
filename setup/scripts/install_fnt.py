import os
import helpers 
import parameters


def install():
    with open(f"{parameters.SCR_DIR}/lists/fonts.lst", "r") as f:
        fonts = f.read().splitlines()

    for font in fonts:
        tar_name, tgt_path = font.split("|")
        tgt_path = tgt_path.replace("$HOME", parameters.HOME_DIR)

        if not os.path.exists(tgt_path):
            try:
                helpers.run(f"mkdir -p {tgt_path}", check=True, output="null", shell=True)
            except PermissionError:
                print("creating the directory as root instead...")
                helpers.run(['sudo', 'mkdir', '-p', tgt_path], check=True, output="null")
            print(f"\033[0;32m[extract]\033[0m {tgt_path} directory created...")

        command = f"sudo tar -xzf \"{parameters.SRC_DIR}/arcs/{tar_name}.tar.gz\" -C \"{tgt_path}/\""
        helpers.run(command, shell=True, output="null")
        print(f"\033[0;32m[extract]\033[0m {tar_name}.tar.gz --> {tgt_path}...")

    print("\033[0;32m[fonts]\033[0m rebuilding font cache...")
    command="fc-cache -f"
    helpers.run(command, shell=True, output="null")
