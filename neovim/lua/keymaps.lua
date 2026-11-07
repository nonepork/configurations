-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--  NOTE: may I interest you in mini.move?
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-n>', '')

vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

vim.keymap.set('n', 'ss', '<cmd>split<CR>', { desc = 'Split horizontally', noremap = true, silent = true })
vim.keymap.set('n', 'sv', '<cmd>vsplit<CR>', { desc = 'Split vertically', noremap = true, silent = true })

-- stolen from and-rs
vim.keymap.set('v', '<', "<gv<C-o>'<", { desc = 'Inner indent while remaining in visual mode' })
vim.keymap.set('v', '>', ">gv<C-o>'<", { desc = 'Outer indent while remaining in visual mode' })

-- greatest remap here
vim.keymap.set('x', 'p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, 'y', [["+y]])
vim.keymap.set('n', 'Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])

vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Diagnostic Config & Keymaps
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = true,
  severity_sort = true,
  float = { border = 'single', source = 'if_many' },
  underline = true,

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>qd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)', noremap = true, silent = true })
vim.keymap.set('n', '<leader>qt', '<cmd>Trouble todo toggle<cr>', { desc = 'Todo List (Trouble)', noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: I use mouse to resize windows btw, I know I know but I can't help myself :p

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next tab', noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Previous tab', noremap = true, silent = true })

--  vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gi', '<cmd>GuessIndent<CR>', { desc = '[G]uess [I]ndent' })
-- NOTE: the K thingy seems to be built-in, so I just use ]d [d to show errors now, gotta
-- figure out a way to copy the errors though.

-- diffmode stuff for myself, jumps to add/delete only
local function jump_diff(direction)
  local line = vim.fn.line '.'
  local last_line = vim.fn.line '$'
  local step = direction == 'next' and 1 or -1

  local function get_diff_type(l)
    if l < 1 or l > last_line + 1 then return nil end
    if vim.fn.diff_filler(l) > 0 then return 'del' end
    local hl_id = vim.fn.diff_hlID(l, 1)
    if hl_id > 0 and vim.fn.synIDattr(hl_id, 'name') == 'DiffAdd' then return 'add' end
    return nil
  end

  while true do
    line = line + step
    if line < 1 or line > last_line + 1 then break end

    local kind = get_diff_type(line)
    -- Stop at any deletion filler, or at the first line of an addition block
    if kind == 'del' or (kind == 'add' and get_diff_type(line - 1) ~= 'add') then
      vim.api.nvim_win_set_cursor(0, { math.min(line, last_line), 0 })
      return
    end
  end
  print 'No more add/delete found'
end

vim.keymap.set('n', ']a', function() jump_diff 'next' end, { desc = 'Jump to next diffmode add/delete' })
vim.keymap.set('n', '[a', function() jump_diff 'prev' end, { desc = 'Jump to previous diffmode add/delete' })

-- [[ Editorconfig custom properties ]]
local ok, editorconfig = pcall(require, 'editorconfig')
if ok then editorconfig.properties.commentstring = function(bufnr, val) vim.bo[bufnr].commentstring = val end end

-- vim: ts=2 sts=2 sw=2 et
