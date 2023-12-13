require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
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
                       "go",
                       "markdown",
                       "markdown_inline"},

  sync_install = false,

  indent = { enable = true },

  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            vim.cmd([[IlluminatePause]])
            return true
        end
    end,

  },
}

