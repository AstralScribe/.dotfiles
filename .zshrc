# PowerLevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/.manjaro-config

# >>> Oh-my-zsh config >>>
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
# <<< Oh-my-zsh config <<<


# >>> User configuration >>>

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# <<< User configuration <<<


# >>> Various Exports >>>

export ZSH="$HOME/.oh-my-zsh"
export MODULAR_HOME="$HOME/.modular"
export PATH="/home/mayank/Documents/scripts:$PATH"
export PATH="/home/mayank/Documents/ori/scripts:$PATH"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
# export PATH="$PATH:/home/mayank/Documents/personal_projects/github_repos/depot_tools"
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# <<< Various Exports <<<


# >>> Source >>>

source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"

# <<< Source <<<


# >>> conda initialize >>>

__conda_setup="$('/home/mayank/Miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mayank/Miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/mayank/Miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/mayank/Miniconda/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<


# >>> Node Export >>>

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# <<< Node Export <<<


# >>> Alias >>>

alias vim=nvim
alias vi=nvim
alias icat="kitten icat"
alias s="kitten ssh"
alias ca="conda activate"
alias cod="conda deactivate"
alias s03="kitten ssh -t ori_system_3090 'cd /media/newhd/ ; zsh --login'"
alias s04="kitten ssh -t ori_system_4090 'cd /media/newhd/ ; zsh --login'"
alias sg="kitten ssh -t global_4090 'cd /media/newhd/ ; zsh --login'"
alias sq="kitten ssh -t ori_system_quadro 'cd /media/ori_quadro/newhd1/ ; zsh --login'"
alias gq="kitten ssh -t global_quadro 'cd /media/ori_quadro/newhd1/ ; zsh --login'"
alias code.="code ."
alias orphans="pacman -Qdtq"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && vim ."
alias nunc='git add . && git commit -m "Novel updated" && git push'
v() {
    z $1 && code .
}
gcwm() {
    git add . && git commit -m $1 && git push
}
dck() {
    docker commit $1 && docker kill $1 && docker system prune
}
mc() {
    mkdir $1 && cd $1
}
# <<< Alias <<<


# >>> Extra Commands >>>

USE_POWERLINE="true"

# <<< Extra Commands <<<
