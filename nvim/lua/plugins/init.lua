local plugins = {
  'web-devicons',
  'telescope',
  'treesitter',
  'lsp-config',

  'autopairs',
  'blink',
  'conform',
  'cutlass',
  'fidget',
  'gitsigns',
  'grug-far',
  'guess-indent',
  'indent-blankline',
  'lazydev',
  'lualine',
  'oil',
  'substitute',
  'surround',
  'todo-comments',
  'tree-sitter-language-injection',
}

for _, plugin in ipairs(plugins) do
  require('plugins.' .. plugin)
end
