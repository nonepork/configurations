return {
    {"marko-cerovac/material.nvim",
    lazy = false, -- Load this before start up 
    priority = 1000, -- Load this before everything
    config = function()
        -- Set colorscheme in here although I don't know why
        vim.cmd([[colorscheme material-deep-ocean]])
    end,},
}
