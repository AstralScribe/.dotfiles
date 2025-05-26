import os

SCR_DIR = "."
SRC_DIR = "../source"
AUR = "paru"
SHELL = "zsh"

HOME_DIR = os.path.expanduser("~")
CONF_DIR = f"{HOME_DIR}/.config"
CACHE_DIR = f"{HOME_DIR}/.cache/myde"
CLONE_DIR = f"{CACHE_DIR}/clone"

CONFIG_FILE = f"{HOME_DIR}/.dotfiles/scripts/config.txt"
