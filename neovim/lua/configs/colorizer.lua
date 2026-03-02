---@type colorizer.SetupOptions
---@diagnostic disable missing-fields
return {
  buftype = {
    'css',
    'scss',
    'javascript',
    'typescript',
    'html',
    'json',
    'yaml',
  },
  lazy_load = true,
  options = {
    parsers = {
      css = true,
      tailwind = { enable = true, lsp = true, update_names = true },
    },
    display = {
      mode = 'virtualtext',
      virtualtext = {
        char = '■',
        position = 'eol',
        hl_mode = 'foreground',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
