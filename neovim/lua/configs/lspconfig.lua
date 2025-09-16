return function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

      -- Useful when your language has ways of declaring types without an actual implementation.
      map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

      -- In C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Symbols are things like variables, functions, types, etc.
      map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

      -- Similar to document symbols, except searches over your entire project.
      map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

      -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic Config
  vim.diagnostic.config {
    underline = true,
    signs = {
      text = vim.g.have_nerd_font and {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN] = 'W',
        [vim.diagnostic.severity.HINT] = 'H',
        [vim.diagnostic.severity.INFO] = 'I',
      },
    } or {},
  }

  -- The servers table comprises of the following sub-tables:
  -- 1. mason
  -- 2. others
  -- Both these tables have an identical structure of language server names as keys and
  -- a table of language server configuration as values.
  ---@class LspServersConfig
  ---@field mason table<string, vim.lsp.Config>
  ---@field others table<string, vim.lsp.Config>
  local servers = {
    --  Add any additional override configuration in any of the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/  --
    --
    --  Feel free to add/remove any LSPs here that you want to install via Mason. They will automatically be installed and setup.
    mason = {
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      -- But for many setups, the LSP (`ts_ls`) will work just fine
      ts_ls = {},
      lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
          python = {
            pythonPath = 'python',
            analysis = {
              reportIgnoreCommentWithoutRule = false,
              reportUnnecessaryTypeIgnoreComment = false,
              reportMissingTypeStubs = false,
              reportUnusedCallResult = false,
              reportAny = false,
              reportExplicitAny = false,
              reportImplicitStringConcatenation = false,
              reportUnreachable = false,
              reportUnknownVariableType = false,
              reportUnknownArgumentType = false,
            },
          },
        },
      },
    },
    others = {},
  }

  for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
    if vim.fn.empty(config) ~= 1 then
      vim.lsp.config(server, config)
    end
  end

  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_enable = true, -- automatically run vim.lsp.enable() for all servers that are installed via Mason
  }

  if vim.fn.empty(servers.others) ~= 1 then
    vim.lsp.enable(vim.tbl_keys(servers.others))
  end
end

-- vim: ts=2 sts=2 sw=2 et
