require "nvchad.options"

local opt = vim.opt

opt.number = true             -- Line number in front of each line
opt.relativenumber = true     -- I didn't know you could (relativelinenumber) + j or k

opt.clipboard = "unnamedplus" -- Uses the clipboard register for all operations except yank.

opt.syntax = "on"             -- Enable syntax highlight stuff

opt.smartindent = true        -- Let vim decides when to indent, when not to.
opt.expandtab = true          -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

opt.encoding = "utf-8"        -- Sets the character encoding used inside Vim.
opt.fileencoding = "utf-8"    -- Sets the character encoding for the file of this buffer.

opt.wrap = false              -- Disable wrap lines

opt.hlsearch = true           -- Set don't highlight on search
opt.incsearch = true          -- Like regex but for vim

opt.scrolloff = 8             -- Pretty cool feature that don't let you lost in the world of code

opt.ruler = true              -- Show the line and column number of the cursor position, separated by a comma.
opt.mouse = "a"               -- Enable the use of the mouse. "a" you can use on all modes
opt.hidden = true             -- When on a buffer becomes hidden when it is |abandon|ed
opt.ttimeoutlen = 0           -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
opt.wildmenu = true           -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
opt.showcmd = true            -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
opt.showmatch = true          -- When a bracket is inserted, briefly jump to the matching one.
opt.inccommand = "split"      -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
opt.splitbelow = true         -- When on, splitting a window will put the new window below the current one

opt.ignorecase = true         -- Case insensitive when searching..
opt.smartcase = true          -- Unless there is capital letter in it

opt.updatetime = 50           -- Updatetime

opt.termguicolors = true      -- Colors

opt.listchars = {
  tab = '▷-',
  trail = '·',
  extends = '◣',
  nbsp = '○'
}
opt.list = true

-- I don't know where to put this
require("nvim-autopairs").remove_rule('"')
require("nvim-autopairs").remove_rule('\'')
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
