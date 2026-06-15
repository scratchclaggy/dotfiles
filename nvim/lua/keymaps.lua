vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>qq', vim.cmd.qa, { desc = '[Q]uit all' })
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

vim.keymap.set('n', '[t', vim.cmd.tabprevious, { desc = 'Previous tab' })
vim.keymap.set('n', ']t', vim.cmd.tabnext, { desc = 'Next tab' })
vim.keymap.set('n', '<leader><tab>n', vim.cmd.tabnew, { desc = 'New tab' })
vim.keymap.set('n', '<leader><tab>c', vim.cmd.tabclose, { desc = 'Close tab' })

-- Better Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Unimpaired inspired keymaps
vim.keymap.set('n', 'yod', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
	{ desc = 'Toggle [D]iagnostics' })
vim.keymap.set('n', 'yow', function() vim.wo.wrap = not vim.wo.wrap end, { desc = 'Toggle line [W]rap' })
vim.keymap.set('n', 'yos', function() vim.wo.spell = not vim.wo.spell end, { desc = 'Toggle [S]pell check' })
