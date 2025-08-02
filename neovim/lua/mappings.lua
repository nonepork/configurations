-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-n>', '')

-- greatest remap here
vim.keymap.set('x', 'p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, 'y', [["+y]])
vim.keymap.set('n', 'Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-up>', '3<C-w>+', { desc = 'Increase vertical window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-down>', '3<C-w>-', { desc = 'Decrease vertical window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-left>', '3<C-w><', { desc = 'Decrease horizontal window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-right>', '3<C-w>>', { desc = 'Increase horizontal window height', noremap = true, silent = true })

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next tab', noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Previous tab', noremap = true, silent = true })
vim.keymap.set('n', 'C', '<cmd>bd<CR>', { desc = 'Close buffer', noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gi', '<cmd>GuessIndent<CR>', { desc = '[G]uess [I]ndent' })

vim.keymap.set('n', 'K', function() -- Stole from petter-tchirkov
  local is_diagnostic = require('misc').is_diagnostic()
  if is_diagnostic == true then
    return vim.diagnostic.open_float { scope = 'cursor', border = 'single' }
  else
    return vim.lsp.buf.hover { border = 'single' }
  end
end, { desc = 'Open docs/Show diagnostic in float' })

-- [[ Autocommands ]]
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
