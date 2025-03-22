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
    },
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
    opts = {
      preview = {
        icon_provider = "devicons",
        filetypes = {
          "md",
          "markdown",
          "norg",
          "rmd",
          "org",
          "vimwiki",
          "typst",
          "latex",
          "quarto",
          "Avante",
          "codecompanion",
        },
        ignore_buftypes = {},

        condition = function(buffer)
          local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt

          if bt == "nofile" and ft == "codecompanion" then
            return true
          elseif bt == "nofile" then
            return false
          else
            return true
          end
        end,
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    config = function()
      require "configs.codecompanion"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "echasnovski/mini.diff", version = false, lazy = true },
    },
  },
}

