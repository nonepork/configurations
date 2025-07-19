return function()
  require('mini.ai').setup { n_lines = 500 }
  require('mini.surround').setup()

  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end

  require('mini.tabline').setup()
  require('mini.pairs').setup()
  require('mini.comment').setup {
    mappings = {
      comment = '',
      comment_line = '<leader>/',
      comment_visual = '<leader>/',
    },
  }
end

-- vim: ts=2 sts=2 sw=2 et
