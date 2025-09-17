return {
  sync_root_with_cwd = true,
  hijack_cursor = true,
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  actions = {
    remove_file = {
      close_window = false,
    },
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    icons = {
      git_placement = 'after',
      modified_placement = 'after',
      diagnostics_placement = 'after',
      glyphs = {
        git = {
          unstaged = '×',
          staged = '✓',
          unmerged = '',
          untracked = '★',
          renamed = '',
          deleted = '󰆴',
          ignored = '◌',
        },
      },
    },
  },
}
