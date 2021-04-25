#!/bin/bash

# Update system
sudo apt update
sudo apt -y upgrade

# Install Neovim + vim-plug
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install -y neovim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Node + Yarn
curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt install -y nodejs
npm i -g yarn

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Fzf and ripgrep
sudo apt install -y fzf
sudo apt install -y ripgrep

# Install fd
sudo apt install -y fd-find
mkdir -p ~/.local/bin
sudo ln -s $(which fdfind) ~/.local/bin/fd

# Set-up symlinks
sudo ln -s ~/.dotfiles/bashrc ~/.bashrc
sudo ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
sudo ln -s ~/.dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
sudo ln -s ~/.dotfiles/gitconfig ~/.gitconfig
sudo ln -s ~/.dotfiles/fdignore ~/.fdignore
sudo ln -s ~/.dotfiles/nvim ~/.config/nvim

