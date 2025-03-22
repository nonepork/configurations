local configs = require "nvchad.configs.cmp"

local cmp = require "cmp"

require("luasnip.loaders.from_vscode").load()

-- configs.options.mapping = {
--   ["<CR>"] = cmp.mapping.confirm {
--     behavior = cmp.ConfirmBehavior.Insert,
--     select = false,
--   },
--
--   ["<Tab>"] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_next_item()
--     elseif require("luasnip").expand_or_jumpable() then
--       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
--     else
--       fallback()
--     end
--   end, { "i", "s" }),
--
--   ["<S-Tab>"] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_prev_item()
--     elseif require("luasnip").jumpable(-1) then
--       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
--     else
--       fallback()
--     end
--   end, { "i", "s" }),
-- }

configs.options.mapping = {
  ["<CR>"] = cmp.mapping.confirm { select = false },
  ["<Tab>"] = cmp.mapping(function(fallback)
    if require("luasnip").expandable() then
      require("luasnip").expand()
    elseif cmp.visible() then
      cmp.select_next_item()
    elseif require("luasnip").jumpable(1) then
      require("luasnip").jump(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
}

configs.options.sources = {
  per_filetype = {
    codecompanion = { "codecompanion" },
  },
}

cmp.setup(configs)
