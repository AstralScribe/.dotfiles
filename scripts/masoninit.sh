#!/bin/bash

VENV="$HOME/.dotfiles/venv"
MASON="$HOME/.dotfiles/scripts/mason"
ENV=$(python ./mason/env_check.py)

pip_check () {
    for i in $(cat "$MASON/requirements.txt");
    do 
        if python -c "import $i" &> /dev/null; then
            printf "$i present.\n"
        else
            echo 0
            return
        fi;
    done;
    echo 1
    return
}

temp=$(pip_check)

if [ $temp = 0 ]; then
    echo "failed."
fi

# if [ $ENV = "conda" ]; then
#     pkg_present="$(pip_check)"
#     if 

# temp="$(pip_check)"

# if [ -d $venv_path ]; then
#     source $venv_path/bin/activate
# elif [ $env = "root" ]; then
#     python -m venv $HOME/.dotfiles/venv
#     source $HOME/.dotfiles/venv/bin/activate
#     env=$(python $HOME/.dotfiles/scripts/env_check.py)
# else
#
# fi
