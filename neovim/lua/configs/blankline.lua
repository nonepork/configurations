return {
  indent = { char = '│', tab_char = '│' },
  exclude = { -- Stole from rezhaTanuharja
    filetypes = { 'tex', 'plaintex', 'bib' },
  },

  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    highlight = { 'Special' },
    priority = 500,
  },
}
