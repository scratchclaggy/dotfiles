vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'colorscheme'

require 'globals'
require 'options'
require 'diagnostic'
require 'keymaps'
require 'autocommands'
require 'commands'
require 'post-install'

require 'plugins'
