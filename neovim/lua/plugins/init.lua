return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    opts = require "configs.treesitter"
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require "configs.autotag"
    end,
    lazy = true,
    event = "VeryLazy",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    lazy = false,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
      require "configs.markview"
    end,
  },

  -- {
  --   "seblyng/roslyn.nvim",
  --   ft = "cs",
  --   ---@module 'roslyn.config'
  --   ---@type RoslynNvimConfig
  --   opts = {
  --     -- your configuration comes here; leave empty for default settings
  --   },
  -- },
}
