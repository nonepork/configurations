return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load this before everything
  config = function()
    -- Set colorscheme in here although I don't know why
    vim.cmd([[colorscheme catppuccin-mocha]])
  end,
}
