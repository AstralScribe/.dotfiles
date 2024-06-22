import datetime
import os
import yaml

import parameters


now = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
BACKUP_DIR = f"{parameters.CONF_DIR}/bkps/{now}"

if not os.path.exists(BACKUP_DIR):
    os.makedirs(BACKUP_DIR, exist_ok=True)

with open("./lists/config.yaml", "r") as f:
    CONFIGS = yaml.safe_load(f)


for name, config in CONFIGS.items():
    print(f"\033[0;32m[Configuring]\033[0m {name} <-- {config.get('path')}")
