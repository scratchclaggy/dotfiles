vim.pack.add { Gh 'nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'lsp_status' },
    lualine_x = { 'location' },
    lualine_y = { 'progress' },
    lualine_z = { { 'datetime', style = '%H:%M' } },
  },
  winbar = {
    lualine_b = { { 'filename', path = 1 } },
    lualine_x = {
      'diagnostics',
      'diff',
      'filetype',
    },
  },
  inactive_winbar = {
    lualine_c = { { 'filename', path = 1 } },
  },
  extensions = { 'mason', 'oil', 'quickfix' },
}
