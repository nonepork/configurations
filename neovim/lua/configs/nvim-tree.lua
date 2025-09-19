return {
  on_attach = function(bufnr)
    local api = require 'nvim-tree.api'
    local opts = function(desc)
      return { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc }
    end
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<C-]>', function()
      local node = api.tree.get_node_under_cursor()
      if node and (node.type == 'directory' or node.parent) then
        local target_dir = node.type == 'directory' and node.absolute_path or node.parent.absolute_path
        api.tree.change_root(target_dir)
        vim.cmd('cd ' .. target_dir) -- This syncs with Telescope
      end
    end, opts 'CD')

    vim.keymap.set('n', '-', function()
      local tree = api.tree.get_nodes() -- Get current root directory from the tree
      if tree and tree.absolute_path then
        local parent_dir = vim.fn.fnamemodify(tree.absolute_path, ':h')
        -- Don't go above root directory
        if parent_dir ~= tree.absolute_path then
          api.tree.change_root(parent_dir)
          vim.cmd('cd ' .. parent_dir)
        end
      end
    end, opts 'Up')
  end,
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
    root_folder_label = false,
    icons = {
      git_placement = 'after',
      modified_placement = 'after',
      diagnostics_placement = 'after',
      glyphs = {
        folder = {
          arrow_closed = '',
          arrow_open = '',
        },
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
