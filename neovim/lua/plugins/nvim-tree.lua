return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = 'Toggle nvim tree' })
    vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { silent = true , desc = 'Focus on nvim tree'})
  end,
}
