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
  'oil',
  'substitute',
  'surround',
  'todo-comments',
}

for _, plugin in ipairs(plugins) do
  require('plugins.' .. plugin)
end
