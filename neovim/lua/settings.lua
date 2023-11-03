vim.scriptencoding = "utf-8"

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor options

vim.o.hlsearch = true           -- Set highlight on search
vim.o.number = true             -- Line number in front of each line
vim.o.clipboard = "unnamedplus" -- Uses the clipboard register for all operations except yank.
vim.o.syntax = "on"             -- Enable syntax highlight stuff
vim.o.autoindent = true         -- Copy indent from current line when starting a new line.
vim.o.expandtab = true          -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
vim.o.shiftwidth = 2            -- Number of spaces to use for each step of (auto)indent.
vim.o.tabstop = 2               -- Number of spaces that a <Tab> in the file counts for.
vim.o.encoding = "utf-8"        -- Sets the character encoding used inside Vim.
vim.o.fileencoding = "utf-8"    -- Sets the character encoding for the file of this buffer.
vim.o.ruler = true              -- Show the line and column number of the cursor position, separated by a comma.
vim.o.mouse = "a"               -- Enable the use of the mouse. "a" you can use on all modes
vim.o.title = true              -- When on, the title of the window will be set to the value of 'titlestring'
vim.o.hidden = true             -- When on a buffer becomes hidden when it is |abandon|ed
vim.o.ttimeoutlen = 0           -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
vim.o.wildmenu = true           -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
vim.o.showcmd = true            -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
vim.o.showmatch = true          -- When a bracket is inserted, briefly jump to the matching one.
vim.o.inccommand = "split"      -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
vim.o.splitbelow = "splitright" -- When on, splitting a window will put the new window below the current one
vim.o.ignorecase = true         -- Case insensitive when searching..
vim.o.smartcase = true          -- Unless there is capital letter in it
vim.o.termguicolors = true      -- Colors
vim.opt.guifont = "JetBrainsMono NFM:h12" -- Font, really long 'cuz the og one didn't work
