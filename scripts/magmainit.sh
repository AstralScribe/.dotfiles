#!/bin/bash

VENV="$HOME/.dotfiles/venv"
MAGMA="$HOME/.dotfiles/scripts/magma"
ENV=$(python $MAGMA/env_check.py)

pip_check () {
    for i in $(cat "$MAGMA/requirements.txt");
    do 
        if python -c "import $i" &> /dev/null; then
            echo "$i absent." >&2
        else
            echo 0
            return
        fi;
    done;
    echo 1
    return
}

pkg_installer () {
    pkg_present=$1
    if [ $pkg_present = 1 ]; then
        echo "All packages present. Magma Init successful." >&2
    elif [ $pkg_present = 0 ]; then
        printf "Some packages absent. Installing them...\n" >&2
        pip install -qqq -r $HOME/.dotfiles/scripts/magma/requirements.txt
        echo "Installation Completed." >&2
    fi
}

if [ $ENV = "conda" ]; then
    pkg_present="$(pip_check)"
    echo "$(pkg_installer $pkg_present)"
     
elif [ $ENV = "venv" ]; then
    pkg_present="$(pip_check)"
    echo "$(pkg_installer $pkg_present)"
else
    if  [ -d "$VENV" ]; then
        source $VENV/bin/activate
        echo "Virtualenv found... Checking packages..."
        pkg_present="$(pip_check)"
        echo "$(pkg_installer $pkg_present)"
        # output=$(pkg_installer $pkg_present)
        # echo $output

    else    
        echo "No virtual env found... Creating env..."
        python -m venv $VENV
        source $VENV/bin/activate
        echo "Env created... Installing packages..."
        pip install -qqq -r $HOME/.dotfiles/scripts/magma/requirements.txt
        echo "Magma setup completed."
    fi
fi
