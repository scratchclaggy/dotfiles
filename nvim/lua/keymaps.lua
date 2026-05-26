vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>qa', vim.cmd.qa, { desc = '[Q]uit [A]ll' })
vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = '[W]rite' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })
vim.keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>-', '<C-w>s', { desc = 'Split horizontally' })

-- Better Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Unimpaired inspired keymaps
vim.keymap.set('n', 'yow', function() vim.wo.wrap = not vim.wo.wrap end, { desc = 'Toggle line [W]rap' })
vim.keymap.set('n', 'yos', function() vim.wo.spell = not vim.wo.spell end, { desc = 'Toggle [S]pell check' })
