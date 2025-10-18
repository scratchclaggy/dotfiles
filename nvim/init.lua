-- [[ My neovim config ]]

require 'option'
require 'keymap'
require 'autocmd'
require 'lazy-bootstrap'
require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin',
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
