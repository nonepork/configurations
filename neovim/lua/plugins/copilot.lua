local gh = require('utils').gh

vim.pack.add { gh 'zbirenbaum/copilot.lua', gh 'fang2hou/blink-copilot' }
require('copilot').setup {
  filetypes = { markdown = false, text = false },
  suggestion = { enabled = false },
  panel = { enabled = false },
  server_opts_overrides = {
    settings = {
      telemetry = {
        telemetryLevel = 'off',
      },
    },
  },
}
