#!/bin/bash

# Install Packages
packages="sudo git make python-pip python npm node rust neovim xclip"
sudo pacman -S --noconfirm $packages
echo 'LunarVim prerequisites installed'

echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers"
echo 'sudo is free'

packages="pulseaudio pavucontrol"
sudo pacman -S --noconfirm $packages
echo 'driver installed'

packages="wget curl tldr bottom unzip"
sudo pacman -S --noconfirm $packages

## yay
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si --noconfirm

echo 'utilites installed'

## git
if [ ! -f ~/.gitconfig ]; then
    echo 'Enter email for git'
    read email
    echo 'Enter user.name for git'
    read name
    git config --global user.email "$email"
    git config --global user.name "$name"
    git config --global credential.helper store
    git config --global --unset https.proxy
    echo 'git config done. You need to generate token(PAT) on web'
fi

## lunarvim
if [ ! -d ~/.npm-global/ ]; then
    mkdir ~/.npm-global/
    npm config set prefix '~/.npm-global'
    if [! grep -q npm-global ~/.profile ]; then
        "export PATH=~/.npm-global/bin:\$PATH" >> ~/.profile
        source ~/.profile
    fi
fi
echo 'npm-global checked'

echo 'prerequisites checked'

LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
y
y
y
y
echo 'Lunarvim Installed!'

# Dot Files
if [ ! -d ~/Dotfiles ]; then
    mkdir ~/Dotfiles
    git clone https://github.com/choikangjae/Dotfiles.git ~/Dotfiles
    echo 'Dotfiles cloned'

    rm ~/.bashrc
    ln -s ~/Dotfiles/bash/.bashrc ~
    source ~/.bashrc
    echo '.bashrc done'
    ln -s ~/Dotfiles/bash/.bash_aliases ~
    echo '.bash_aliases done'
    ln -s ~/Dotfiles/bash/.bash_functions ~
    echo '.bash_functions done'

    ln -s ~/Dotfiles/vim/config.lua ~/.config/lvim/
    echo 'config.lua done'

    if [! -d ~/.local/share/fonts ]; then
        mkdir ~/.local/share/fonts/
        ln -s ~/Dotfiles/font/JetBrainsMonoNerdFont-Regular.ttf ~/.local/share/fonts/
        fc-cache
fi

# DE
sudo pacman -S --noconfirm plasma-meta konsole dolphin ark

## Ungoogled-chromium
yay --save --nocleanmenu --nodiffmenu ungoogled-chromium-bin

## ibus
sudo pacman -S --noconfirm ibus ibus-hangul


