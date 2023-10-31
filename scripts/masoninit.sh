#!/bin/bash

venv_path="$HOME/.dotfiles/venv"
env=$(python env_check.py)

echo $env

if [ -d $venv_path ]; then
    source $HOME/.dotfiles/venv/bin/activate
elif [ $env = "root" ]; then
    python -m venv $HOME/.dotfiles/venv
    source $HOME/.dotfiles/venv/bin/activate
    env=$(python $HOME/.dotfiles/scripts/env_check.py)
else

fi

    
