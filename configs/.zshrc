# >>> PowerLevel10k >>>

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/.manjaro-config

# <<< PowerLevel10k <<<


# >>> Oh-my-zsh config >>>

ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto
COMPLETION_WAITING_DOTS="true"
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

# <<< Oh-my-zsh config <<<


# >>> User configuration >>>

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# <<< User configuration <<<


# >>> Various Exports >>>

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export CUDA_HOME="/opt/cuda"

# <<< Various Exports <<<


# >>> Source >>>

source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"
eval "$(ssh-agent)" > /dev/null

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

# Renames
alias vim=nvim
alias vi=nvim
alias code="code --ozone-platform-hint=wayland"
alias code.="$code ."

# Remote Connections
alias s="ssh"
alias s03="ssh -t ori_3090 'cd /media/newhd/ ; zsh --login'"
alias s04="ssh -t ori_4090 'cd /media/newhd/ ; zsh --login'"
alias sg="ssh -t global_4090 'cd /media/newhd/ ; zsh --login'"
alias sq="ssh -t ori_quadro 'cd /media/ori_quadro/newhd1/ ; zsh --login'"
alias gq="ssh -t global_quadro 'cd /media/ori_quadro/newhd1/ ; zsh --login'"

# Code related alias
alias g20="g++ -std=c++20"
alias c20="clang++ -std=c++20"
alias ca="conda activate"
alias cod="conda deactivate"
alias pa="source .venv/bin/activate"
alias pd="deactivate"
alias infer_env="source $HOME/Documents/dev-hub/neural-lab/.venv/bin/activate"

# Package and Configs
alias orphans="pacman -Qdtq"
alias external_pkgs="pacman -Qem"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && vim ."

# System shortcuts
alias :q="exit"
alias sl="ls"
mc() {
    mkdir $1 && cd $1
}
list_files() {
    find $1 -type f | wc -l
}

# VCS and Docker
alias nunc='git pull && git add . && git commit -m "Novel updated" && git push'
gcwm() {
    git add . && git commit -m $1 && git push
}
dck() {
    docker commit $1 && docker kill $1 && docker system prune
}

# <<< Alias <<<


# >>> Extra Commands >>>

USE_POWERLINE="true"
LS_COLORS+=':ow=01;34'

# <<< Extra Commands <<<