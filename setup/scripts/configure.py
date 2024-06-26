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
            shutil.copytree(src=pkg.src_path, dst=pkg.dst_path)

