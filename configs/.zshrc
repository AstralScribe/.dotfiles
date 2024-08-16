# >>> PowerLevel10k >>>

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# <<< PowerLevel10k <<<


# >>> Zinit >>>

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# <<< Zinit <<<


# >>> Zinit plugnis >>>

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

# <<< Zinit <<<


# >>> User configuration >>>

# Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt correct                                                  # Auto correct mistakes


# Keybindings
bindkey -e

bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi

bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key

if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi

bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' backward-kill-word                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
# bindkey '^[[5~' history-beginning-search-backward               # Page up key
# bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^[[Z' undo                                             # Shift+tab undo last action

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-search-backward
bindkey "$terminfo[kcud1]" history-search-forward

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Completion styling
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' menu no
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# <<< User configuration <<<


# >>> Various Exports >>>

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export CUDA_HOME="/opt/cuda"
export PATH="$PATH:/usr/include/python3.12"

# <<< Various Exports <<<


# >>> Source >>>

# eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# <<< Source <<<


# >>> conda initialize >>>

__conda_setup="$('/home/mayank/Miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
alias ls='ls --color'
alias vim=nvim
alias vi=nvim
# alias code="code --hint"
alias code.="code ."
alias t="todo.sh"

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
