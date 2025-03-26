# >>> Alias >>>

# Renames
# alias ls='LC_COLLATE=C ls -l --color'
alias ls='ls --color'
alias vim=nvim
alias vi=nvim
alias code="code --ozone-platform=wayland"
alias code.="$code ."
alias t="todo.sh"

# Remote Connections
alias s="ssh"
alias s03="ssh -t ori_3090 'cd /media/newhd/ ; zsh --login'"
alias s04="ssh -t ori_4090 'cd /media/newhd/ ; zsh --login'"
alias sg="ssh -t global_4090 'cd /media/newhd/ ; bash --login'"
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
ts() {
    number=$(echo "$1" | grep -o '^[0-9]\+' | xargs printf '%04d')
    title=$(echo "$1" | sed 's/^[0-9]*\. //' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    touch "${number}_${title}"
}

cd() {
  z $1 || return

  if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi

  if [ -d ".venv" ]; then
    env_dir=".venv"
  elif [ -d "venv" ]; then
    env_dir="venv"
  else
    return
  fi
  source $env_dir/bin/activate
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
