-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
local default_setup = function (server)
  lspconfig[server].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = {},
  handlers = { default_setup },
}
