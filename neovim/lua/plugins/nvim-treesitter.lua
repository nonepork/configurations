return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        ensure_installed = { "c",
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
                             "markdown",
                             "markdown_inline"},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
  end
}
