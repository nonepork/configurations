local function flip_highlights(hl_names)
  for _, name in ipairs(hl_names) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    if hl.fg or hl.bg then
      vim.api.nvim_set_hl(0, name, {
        fg = hl.bg,
        bg = hl.fg,
        bold = hl.bold,
        italic = hl.italic,
        underline = hl.underline,
      })
    end
  end
end

return function()
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false },
    },
    transparent = true,
    on_highlights = function(hl, c)
      -- setting some backgrounds to transparent
      hl.TelescopeResultsBorder = { fg = c.bg_dark, bg = 'NONE' }
      hl.TelescopeResultsNormal = { fg = c.fg, bg = 'NONE' }
      hl.TelescopePreviewBorder = { fg = c.bg_dark, bg = 'NONE' }
      hl.TelescopePreviewNormal = { fg = c.fg, bg = 'NONE' }
      hl.TelescopePromptBorder = { fg = c.bg_dark, bg = 'NONE' }
      hl.TelescopePromptNormal = { fg = c.fg, bg = 'NONE' }
      hl.NvimTreeNormal = { bg = 'NONE' }
      hl.NvimTreeNormalNC = { bg = 'NONE' }
      hl.NvimTreeWinSeparator = { fg = 'NONE', bg = 'NONE' }
      hl.MiniClueBorder = { fg = c.bg_dark, bg = 'NONE' }
      hl.MiniTablineHidden = { fg = c.dark3, bg = 'NONE' }
      hl.MiniStatuslineDevinfo = { fg = c.fg, bg = 'NONE' }
      hl.MiniStatuslineFileinfo = { fg = c.dark3, bg = 'NONE' }
      -- hl.NvimTreeRootFolder = { fg = c.dark3, bg = 'NONE' }
    end,
  }

  vim.cmd.colorscheme 'tokyonight-moon'

  -- some requires to be set after colorscheme is loaded
  vim.cmd 'highlight MiniClueDescSingle guibg=NONE'
  vim.cmd 'highlight MiniClueDescGroup guibg=NONE'
  vim.cmd 'highlight MiniTablineVisible guibg=NONE'
  vim.cmd 'highlight MiniTablineFill guibg=NONE'
  vim.cmd 'highlight MiniTablineCurrent guibg=NONE gui=bold'
  vim.cmd 'highlight MiniTablineModifiedCurrent guibg=NONE gui=bold'
  vim.cmd 'highlight MiniTablineModifiedVisible guibg=NONE'
  vim.cmd 'highlight MiniTablineModifiedHidden guibg=NONE'
  vim.cmd 'highlight TabLine guibg=NONE'
  vim.cmd 'highlight TabLineFill guibg=NONE'
  vim.cmd 'highlight NormalFloat guibg=NONE'
  vim.cmd 'highlight FloatBorder guibg=NONE'
  vim.cmd 'highlight MiniStatuslineFilename guibg=NONE'
  vim.cmd 'highlight MiniStatuslineDevinfo guibg=NONE'
  vim.cmd 'highlight StatusLine guibg=NONE'
  flip_highlights {
    'MiniStatuslineModeNormal',
    'MiniStatuslineModeReplace',
    'MiniStatuslineModeCommand',
    'MiniStatuslineModeOther',
    'MiniStatuslineModeVisual',
    'MiniStatuslineModeInsert',
  }
end
