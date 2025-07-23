return function()
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false },
    },
    transparent = true,
    on_highlights = function(hl, c)
      -- setting some backgrounds to transparent
      hl.TelescopeResultsBorder = {
        fg = c.bg_dark,
        bg = 'NONE',
      }

      hl.TelescopeResultsNormal = {
        fg = c.fg,
        bg = 'NONE',
      }

      hl.TelescopePreviewBorder = {
        fg = c.bg_dark,
        bg = 'NONE',
      }

      hl.TelescopePreviewNormal = {
        fg = c.fg,
        bg = 'NONE',
      }

      hl.TelescopePromptBorder = {
        fg = c.bg_dark,
        bg = 'NONE',
      }

      hl.TelescopePromptNormal = {
        fg = c.fg,
        bg = 'NONE',
      }

      hl.NvimTreeNormal = {
        bg = 'NONE',
      }

      hl.NvimTreeNormalNC = {
        bg = 'NONE',
      }

      hl.NvimTreeWinSeparator = {
        fg = 'NONE',
        bg = 'NONE',
      }
    end,
  }

  vim.cmd.colorscheme 'tokyonight-moon'
end
