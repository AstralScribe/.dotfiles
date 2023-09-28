if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/mayank/Miniconda/bin/conda
    eval /home/mayank/Miniconda/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

export PATH="/home/mayank/Documents/scripts:$PATH"

# >>> Alias >>>

alias vim=nvim
alias vi=nvim
alias icat="kitten icat"
alias s="kitten ssh"
alias ca="conda activate"
alias cod="conda deactivate"
alias s04="kitten ssh -t ori_system_4090 'cd /media/newhd/ ; zsh --login'"
alias sg="kitten ssh -t global_ori 'cd /media/newhd/ ; zsh --login'"
alias s03="kitten ssh -t ori_system_3090 'cd /media/newhd/ ; zsh --login'"

# <<< Alias <<<

starship init fish | source

