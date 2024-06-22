#!/bin/bash
selected=`cat ~/.dotfiles/cht/cht-langs ~/.dotfiles/cht/cht-cmds | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

echo $selected

read -p "Enter Query: " query

if grep -qs "$selected" ~/cht-langs; then
    query=`echo $query | tr ' ' '+'`
    bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    bash -c "curl -s cht.sh/$selected~$query | less"
fi

