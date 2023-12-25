return {
    {"catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- Load this before start up 
    priority = 1000, -- Load this before everything
    config = function()
        -- Set colorscheme in here although I don't know why
        vim.cmd([[colorscheme catppuccin-frappe]])
    end,},
}
