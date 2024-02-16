return {
    "https://github.com/mbbill/undotree",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { silent = true, desc = 'Toggle nvim tree' })
    end,
}
