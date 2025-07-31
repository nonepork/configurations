return function()
  require('mini.ai').setup { n_lines = 500 }
  require('mini.surround').setup()

  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_mode = function() -- Are we supposed to overwrite functions lol
    local modes = {
      ['n'] = { long = 'Normal', short = 'N', hl = 'MiniStatuslineModeNormal' },
      ['v'] = { long = 'Visual', short = 'V', hl = 'MiniStatuslineModeVisual' },
      ['V'] = { long = 'V-Line', short = 'V-L', hl = 'MiniStatuslineModeVisual' },
      [''] = { long = 'V-Block', short = 'V-B', hl = 'MiniStatuslineModeVisual' },
      ['s'] = { long = 'Select', short = 'S', hl = 'MiniStatuslineModeVisual' },
      ['S'] = { long = 'S-Line', short = 'S-L', hl = 'MiniStatuslineModeVisual' },
      [''] = { long = 'S-Block', short = 'S-B', hl = 'MiniStatuslineModeVisual' },
      ['i'] = { long = 'Insert', short = 'I', hl = 'MiniStatuslineModeInsert' },
      ['R'] = { long = 'Replace', short = 'R', hl = 'MiniStatuslineModeReplace' },
      ['c'] = { long = 'Command', short = 'C', hl = 'MiniStatuslineModeCommand' },
      ['r'] = { long = 'Prompt', short = 'P', hl = 'MiniStatuslineModeOther' },
      ['!'] = { long = 'Shell', short = 'Sh', hl = 'MiniStatuslineModeOther' },
      ['t'] = { long = 'Terminal', short = 'T', hl = 'MiniStatuslineModeOther' },
    }

    local mode_code = vim.fn.mode()
    local mode_info = modes[mode_code] or { long = mode_code, short = mode_code, hl = 'MiniStatuslineModeOther' }

    return ' ', mode_info.hl
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'NvimTree',
    callback = function(args)
      vim.b.ministatusline_disable = true
    end,
  })

  require('mini.tabline').setup()
  require('mini.pairs').setup()
  require('mini.comment').setup {
    mappings = {
      comment = '',
      comment_line = '<leader>/',
      comment_visual = '<leader>/',
    },
  }

  local clue = require 'mini.clue'
  clue.setup {
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = '[', desc = 'Previous' },
      { mode = 'n', keys = ']', desc = 'Next' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 's' },
      { mode = 'x', keys = 's' },
    },

    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),

      -- Grouping
      { mode = 'n', keys = '<leader>f', desc = '[F]ind' },
      { mode = 'n', keys = '<leader>t', desc = '[T]oggle' },
      { mode = 'n', keys = '<leader>h', desc = 'Git [H]unk' },
      { mode = 'v', keys = '<leader>h', desc = 'Git [H]unk' },
    },

    window = {
      delay = 500,
      config = {
        width = 'auto',
      },
    },
  }
end

-- vim: ts=2 sts=2 sw=2 et
