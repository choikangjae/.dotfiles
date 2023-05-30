export BASH=~/.bashrc

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

alias vn='lvim ~/.config/nvim/init.vim'
alias vv='lvim ~/.config/lvim/config.lua'

alias vb='lvim $BASH'
alias sb='source $BASH'
alias vf='lvim ~/.bash_functions'
alias va='lvim ~/.bash_aliases'
alias rm='rm -i'

alias ...='cd ../../'
alias ....='cd ../../../'
alias c='clear'

alias vi=lvim
alias top='atop'

alias py='python3'
alias man='tldr'
alias clone='git clone --depth=1'

alias d='docker'
alias dd='docker-compose down'
alias dup='docker-compose up -d'

alias cr='cargo run'
alias cb='cargo build'
