return {
  'saghen/blink.cmp',
  event = 'VeryLazy',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    appearance = { nerd_font_variant = 'normal' },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    fuzzy = { implementation = 'lua' },
    keymap = { preset = 'default' },
    signature = { enabled = true },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
  },
}
