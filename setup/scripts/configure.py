import datetime
import os

import parameters


now = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
BACKUP_DIR = f"{parameters.CONF_DIR}/bkps/{now}"

if not os.path.exists(BACKUP_DIR):
    os.makedirs(BACKUP_DIR, exist_ok=True)


