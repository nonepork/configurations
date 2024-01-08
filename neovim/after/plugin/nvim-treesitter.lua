local rainbow = require 'rainbow-delimiters'

require("rainbow-delimiters.setup").setup({
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
})

vim.cmd([[highlight RainbowDelimiterRed guifg=#FFADAD]])
vim.cmd([[highlight RainbowDelimiterYellow guifg=#FFD6A5]])
vim.cmd([[highlight RainbowDelimiterBlue guifg=#FDFFB6]])
vim.cmd([[highlight RainbowDelimiterOrange guifg=#CAFFBF]])
vim.cmd([[highlight RainbowDelimiterGreen guifg=#9BF6FF]])
vim.cmd([[highlight RainbowDelimiterViolet guifg=#A0C4FF]])
vim.cmd([[highlight RainbowDelimiterCyan guifg=#BDB2FF]])

require("nvim-highlight-colors").setup({
    render = 'background'
})

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

        -- I put the disable plugin if size too big in here because yes
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                vim.cmd([[HighlightColorsOff]])
                vim.cmd([[IlluminatePause]])
                vim.cmd([[syntax off]])
                rainbow.disable()
                return true
            end
        end,
    },
}
