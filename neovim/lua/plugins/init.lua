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
    opts = {
      auto_install = true,
      ensure_installed = {
        "c",
        "c_sharp",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "html",
        "css",
        "python",
        "regex",
        "bash",
        "go",
        "markdown",
        "markdown_inline",
        "tsx",
      },
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "css",
          "lua",
          "xml",
          "php",
          "markdown",
        },
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
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
    lazy = false,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
}
