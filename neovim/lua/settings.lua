vim.scriptencoding = "utf-8"

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor options

vim.opt.number = true             -- Line number in front of each line
vim.opt.relativenumber = true     -- I didn't know you could (relativelinenumber) + j or k

vim.opt.clipboard = "unnamedplus" -- Uses the clipboard register for all operations except yank.

vim.opt.syntax = "on"             -- Enable syntax highlight stuff

vim.opt.smartindent = true        -- Let vim decides when to indent, when not to.
vim.opt.tabstop = 4               -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4           -- I dont know what this is to be honest, tell me if you know :)
vim.opt.shiftwidth = 4            -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true          -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

vim.opt.encoding = "utf-8"        -- Sets the character encoding used inside Vim.
vim.opt.fileencoding = "utf-8"    -- Sets the character encoding for the file of this buffer.

vim.opt.wrap = false              -- Disable wrap lines

vim.opt.hlsearch = true           -- Don't highlight on search
vim.opt.incsearch = true          -- Like regex but for vim

vim.opt.scrolloff = 8             -- Pretty cool feature that don't let you lost in the world of code

vim.opt.ruler = true              -- Show the line and column number of the cursor position, separated by a comma.
vim.opt.mouse = "a"               -- Enable the use of the mouse. "a" you can use on all modes
vim.opt.hidden = true             -- When on a buffer becomes hidden when it is |abandon|ed
vim.opt.ttimeoutlen = 0           -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
vim.opt.wildmenu = true           -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
vim.opt.showcmd = true            -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
vim.opt.showmatch = true          -- When a bracket is inserted, briefly jump to the matching one.
vim.opt.inccommand = "split"      -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
vim.opt.splitbelow = true         -- When on, splitting a window will put the new window below the current one

vim.opt.ignorecase = true         -- Case insensitive when searching..
vim.opt.smartcase = true          -- Unless there is capital letter in it

vim.opt.updatetime = 50           -- Updatetime

vim.opt.termguicolors = true      -- Colors
-- vim.opt.guifont = "VictorMono Nerd Font Mono:h12"

vim.opt.listchars = {
  tab = '▷-',
  trail = '·',
  extends = '◣',
  nbsp = '○'
}
vim.opt.list = true

-- Don't left netrw open a buffer after opening a file. For bufferline
vim.g.netrw_fastbrowse = 0
