-- NOTE: why does kickstart.nvim's code look like that
return {
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby', 'cpp' } },
}

-- vim: ts=2 sts=2 sw=2 et
