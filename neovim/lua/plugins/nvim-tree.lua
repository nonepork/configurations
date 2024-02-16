return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { silent = true, desc = 'Toggle nvim tree' })
        vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeFocus, { silent = true , desc = 'Focus on nvim tree'})
    end,
}
