# dotfiles
If you've found this repo, please feel free to have a look around but know that this is just for my personal use.
All the notes below are generally specific to getting things set up on Ubuntu for my personal needs and may not apply to your environment.
The directory structure is designed for use with GNU stow.


## Getting started
- Download Bitwarden for Firefox
- Log into GitHub
- Install git, stow
- Generate keygen `ssh-keygen`
- Add public key to GitHub ssh keys
- Download this repo `git clone git@github.com:scratchclaggy/dotfiles.git .dotfiles`
- Stow necessary directories
- Install (kitty)[https://sw.kovidgoyal.net/kitty/binary/]
- Install (starship)[https://github.com/starship/starship] 
- Install (JetBrains Mono)[https://www.jetbrains.com/lp/mono/]
    - Move into `/usr/share/fonts/truetype/JetBrainsMono`
- Install (neovim)[https://github.com/neovim/neovim]
    - You may need fuse: 
        - `sudo add-apt-repository universe`
        - `sudo apt install libfuse2`
    - Move the app image to `.local/bin`
    - Run `PackerSync`
    - Install treesitter grammar `TSInstall bash c cpp css html go javascript lua python rust typescript`
- Install with apt:
    - bat
        - `ln -s /usr/bin/batcat ~/.local/bin/bat`
    - exa
    - fd
        - `ln -s $(which fdfind) ~/.local/bin/fd`
    - fzf
        - `apt-cache show fzf`
    - ripgrep
    - zoxide
    - zsh
- Install (nvm)[https://github.com/nvm-sh/nvm]
- Set up different (language servers)[https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md]
    - `npm i -g bash-language-server`
    - `npm i -g @tailwindcss/language-server`
    - `npm i -g typescript typescript-language-server`
- Install thefuck with `pip3 install thefuck --user`
- Install (Discord)[https://discord.com/download]
