return function()
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false },
    },
  }

  vim.cmd.colorscheme 'tokyonight-moon'
end
