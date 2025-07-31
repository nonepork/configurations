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
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = require 'configs.fidget' },
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
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
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
    opts = { signs = false },
  },

  {
    'echasnovski/mini.nvim',
    config = require 'configs.mini',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'OXY2DEV/markview.nvim' },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    lazy = false,
    opts = require 'configs.treesitter',
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    init = function()
      local arg = vim.fn.argv(0)
      local stat = vim.loop.fs_stat(arg or '')
      if stat and stat.type == 'directory' then
        vim.api.nvim_create_autocmd('VimEnter', {
          once = true,
          callback = function()
            require('nvim-tree.api').tree.open()
          end,
        })
      end
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = require 'configs.blankline',
  },

  {
    'catgoose/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = require 'configs.colorizer',
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
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
