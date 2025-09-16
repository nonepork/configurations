return function()
  require('mini.ai').setup { n_lines = 500 }
  require('mini.pairs').setup()
  require('mini.surround').setup()

  local statusline = require 'mini.statusline'
  statusline.setup {
    use_icons = vim.g.have_nerd_font,
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
        local git = MiniStatusline.section_git { trunc_width = 40 }
        local diff = MiniStatusline.section_diff { trunc_width = 75 }
        local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
        local filename = MiniStatusline.section_filename { trunc_width = 140 }
        local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
        local location = MiniStatusline.section_location { trunc_width = 75 }
        local search = MiniStatusline.section_searchcount { trunc_width = 75 }

        return MiniStatusline.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, diagnostics } },
          { hl = mode_hl, strings = { search, location } },
        }
      end,
    },
  }
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

    return mode_info.short, mode_info.hl
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_filename = function(args)
    if vim.bo.buftype == 'terminal' then
      return '%t'
    end

    if vim.fn.expand '%' == '' then
      return '[no name]'
    end

    if statusline.is_truncated(args.trunc_width) then
      return '%t%m%r' -- Just filename when truncated
    else
      local parent = vim.fn.expand '%:h:t'
      local filename = vim.fn.expand '%:t'

      return parent .. '/' .. filename .. ' %m%r'
    end
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_git = function(args)
    if statusline.is_truncated(args.trunc_width) then
      return ''
    end

    local branch = vim.g.gitsigns_head

    if branch == nil or branch == '' then
      local use_icons = vim.g.have_nerd_font
      local icon = args.icon or (use_icons and '' or 'Git')
      return icon .. ' No branch'
    end

    if string.len(branch) > 20 then
      branch = branch:sub(1, 20) .. '...'
    end

    local use_icons = vim.g.have_nerd_font
    local icon = args.icon or (use_icons and '' or 'Git')
    return icon .. ' ' .. branch
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_diff = function(args)
    if statusline.is_truncated(args.trunc_width) then
      return ''
    end

    local statuses = vim.b.gitsigns_status_dict
    if statuses == nil then
      return ''
    end

    local changes = statuses.changed or 0
    local additions = statuses.added or 0
    local deletions = statuses.removed or 0

    return ' ' .. '%#GitSignsChange#~' .. changes .. ' %#GitSignsAdd#+' .. additions .. ' %#GitSignsDelete#-' .. deletions .. '%*'
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_diagnostics = function(args)
    if statusline.is_truncated(args.trunc_width) then
      return ''
    end

    if not rawget(vim, 'lsp') then
      return ''
    end

    local get_diagnostic_count = function(severity)
      local count = vim.diagnostic.count(0, { severity = severity })[severity]
      return count or 0
    end

    local error_count = get_diagnostic_count(vim.diagnostic.severity.ERROR)
    local warning_count = get_diagnostic_count(vim.diagnostic.severity.WARN)
    local info_count = get_diagnostic_count(vim.diagnostic.severity.INFO)
    local hint_count = get_diagnostic_count(vim.diagnostic.severity.HINT)
    local infonhints_count = info_count + hint_count

    local parts = {}

    if error_count > 0 then
      table.insert(parts, '%#DiagnosticError#E' .. error_count .. '%*')
    end

    if warning_count > 0 then
      table.insert(parts, '%#DiagnosticWarn#W' .. warning_count .. '%*')
    end

    if infonhints_count > 0 then
      table.insert(parts, '%#DiagnosticHint#I' .. infonhints_count .. '%*')
    end

    if #parts == 0 then
      return ''
    end

    return table.concat(parts, ' ')
  end

  require('mini.tabline').setup {
    show_icons = false,
    tabpage_section = 'right',
    format = function(buf_id, label)
      local fixed_width = 20
      local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf_id), ':t')
      if name == '' then
        name = '[no name]'
      end

      -- Truncate if necessary
      if #name > fixed_width - 2 then
        name = name:sub(1, fixed_width - 3) .. '…'
      end

      local content_width = #name
      local total_padding = fixed_width - 2 - content_width
      local left_padding = math.floor(total_padding / 2)
      local right_padding = math.ceil(total_padding / 2)

      local padded = ' ' .. string.rep(' ', left_padding) .. name .. string.rep(' ', right_padding) .. ' '

      return padded
    end,
  }
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
