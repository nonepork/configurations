return function()
  -- NOTE: uncomment those lines to install parsers on startup, or use `:TSInstall <language>` to install them manually

  -- local parsers = {
  --   'bash',
  --   'c',
  --   'diff',
  --   'html',
  --   'javascript',
  --   'jsdoc',
  --   'json',
  --   'lua',
  --   'luadoc',
  --   'luap',
  --   'markdown',
  --   'markdown_inline',
  --   'printf',
  --   'python',
  --   'query',
  --   'regex',
  --   'toml',
  --   'tsx',
  --   'typescript',
  --   'vim',
  --   'vimdoc',
  --   'xml',
  --   'yaml',
  -- }
  -- require('nvim-treesitter').install(parsers)
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      -- for more info on folds see `:help folds`
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldmethod = 'expr'

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

-- vim: ts=2 sts=2 sw=2 et
