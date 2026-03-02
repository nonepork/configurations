return function()
  --  TODO: make this less redundant

  --  This function gets run when an LSP attaches to a particular buffer.
  --  That is to say, every time a new file is opened that is associated with
  --  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --  function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- In C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Cool hover highlight
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
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
      -- code, if the language server you are using supports them.
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic Config
  vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    float = {
      border = 'single',
      source = 'if_many',
    },

    underline = true,
    signs = {
      text = vim.g.have_nerd_font and {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN] = 'W',
        [vim.diagnostic.severity.HINT] = 'H',
        [vim.diagnostic.severity.INFO] = 'I',
      },
    } or {},

    jump = { float = true },
  }

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- Special Lua Config, as recommended by neovim help docs
    stylua = {}, -- Used to format Lua code
    lua_ls = {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      settings = {
        Lua = {},
      },
    },
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            allowedUntypedLibraries = {
              'reportIgnoreCommentWithoutRule',
              'reportUnnecessaryTypeIgnoreComment',
              'reportMissingTypeStubs',
              'reportUnusedCallResult',
              'reportAny',
              'reportExplicitAny',
              'reportImplicitStringConcatenation',
              'reportUnreachable',
              'reportUnknownVariableType',
              'reportUnknownArgumentType',
            },
            typeCheckingMode = 'basic',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
          },
        },
        python = {
          pythonPath = 'python',
        },
      },
    },
  }

  -- Ensure the servers and tools above are installed
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'black',
    'clangd',
    'cssls',
    'gopls',
    'intelephense',
    'isort',
    'jsonls',
    'prettierd',
    'rust_analyzer',
    'tailwindcss',
    'ts_ls',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    ensure_installed = {}, -- we use mason-tool-installer to install
    automatic_enable = true, -- automatically run vim.lsp.enable() for all servers that are installed via Mason
  }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
  end
end

-- vim: ts=2 sts=2 sw=2 et
