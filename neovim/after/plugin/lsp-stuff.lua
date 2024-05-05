local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    lspconfig[server].setup({
        capabilities = lsp_capabilities,
    })
end

local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '󰌵' },
    { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
    signs = {
        active = signs, -- show signs
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = 'minimal',
        border = 'single',
        source = 'always',
        header = 'Diagnostic',
        prefix = '',
    },
}

vim.diagnostic.config(config)

vim.cmd([[hi DiagnosticVirtualTextWarn guifg=#e0af68]])
vim.cmd([[hi DiagnosticWarn guifg=#e0af68]])

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {default_setup},
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = cmp.mapping(function (fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
    },
})
