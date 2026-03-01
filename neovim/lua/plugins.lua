---@module 'lazy'
---@type LazySpec
require('lazy').setup({
  {
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = require 'configs.gitsigns',
  },

  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = require 'configs.telescope',
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = require 'configs.lazydev',
  },

  {
    'mason-org/mason.nvim',
    cmd = { 'Mason' },
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = require 'configs.fidget' },
      'saghen/blink.cmp',
    },
    config = require 'configs.lspconfig',
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]or[m]at buffer',
      },
    },
    opts = require 'configs.conform',
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
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
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
      'fang2hou/blink-copilot',
    },
    opts = require 'configs.blink',
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = require 'configs.colorscheme',
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },

  {
    'echasnovski/mini.nvim',
    config = require 'configs.mini',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    dependencies = {
      'MeanderingProgrammer/render-markdown.nvim',
      config = require 'configs.markdown',
    },
    opts = require 'configs.treesitter',
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = require 'configs.nvim-tree',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = require 'configs.blankline',
  },

  {
    'catgoose/nvim-colorizer.lua',
    event = { 'BufReadPre' },
    opts = require 'configs.colorizer',
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = require 'configs.copilot',
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = require 'configs.tree-context',
  },

  {
    'folke/trouble.nvim',
    opts = {},
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'TobinPalmer/rayso.nvim',
    cmd = { 'Rayso' },
    opts = {},
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'spellfile',
        'tarPlugin',
        'zipPlugin',
        'man', -- this is not sexist
        'tutor',
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
