return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
        -- disable until lualine loads
        vim.opt.laststatus = 0
    end,
}
