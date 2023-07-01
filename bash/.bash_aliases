export BASH=~/.bashrc

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

alias vn='lvim ~/.config/nvim/init.vim'
alias vv='lvim ~/.config/lvim/config.lua'

alias vb='lvim $BASH'
alias sb='source $BASH'
alias vz='lvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vf='lvim ~/.bash_functions'
alias va='lvim ~/.bash_aliases'
alias var='lvim ~/.bash_arch'

alias ...='cd ../../'
alias ....='cd ../../../'
alias c='clear'

alias vi=lvim
alias top='atop'
# alias btm='sudo btm'

# python
alias py='python3'
alias activate='source .venv/bin/activate'

# git
alias clone='git clone --depth=1'
alias lg='lazygit'

# docker
alias d='docker'
alias dd='docker-compose down'
alias dup='docker-compose up -d'

# cargo
alias cr='cargo run'
alias cb='cargo build'

# npm
alias ns='npm start'
alias nt='npm test'

# alternatives
alias cat='bat'
alias ping='prettyping'
alias grep='rg'

# system
alias servicepath='cd /etc/systemd/system/'
alias logpath='cd /var/log/'
alias showsystem='sudo inxi -Fxxxx'
alias grubopen='sudo lvim /etc/default/grub'
alias motherboard='sudo dmidecode -t 2'
alias watch-kernel-buffer='sudo dmesg -w'
alias watch-user-dev='udevadm monitor --env'
alias devicelist='cat /proc/bus/input/devices'
alias battery='upower --dump'
