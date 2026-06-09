import sys
import os

def getenv():
    if (os.getenv("CONDA_DEFAULT_ENV")):
        env = "conda"
    elif (sys.prefix != sys.base_prefix):
        env = "venv"
    else:
        env = "root"

    return env

if __name__ == "__main__":
    print(getenv())

