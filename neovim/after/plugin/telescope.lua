local colors = require("nightfox.palette").load("carbonfox")
local colors2 = require("nightfox.palette").load("nightfox")
local TelescopeColor = {
    TelescopeMatching = { fg = colors2.orange.bright },
    TelescopeSelection = { fg = colors.fg1, bg = colors.bg2, bold = true },

    TelescopePromptPrefix = { bg = colors.bg2 },
    TelescopePromptNormal = { bg = colors.bg2 },
    TelescopeResultsNormal = { bg = colors.bg1 },
    TelescopePreviewNormal = { bg = colors.bg1 },
    TelescopePromptBorder = { bg = colors.bg2, fg = colors.bg2 },
    TelescopeResultsBorder = { bg = colors.bg1, fg = colors.bg1 },
    TelescopePreviewBorder = { bg = colors.bg1, fg = colors.bg1 },
    TelescopePromptTitle = { bg = colors.red.base, fg = colors.black.dim },
    TelescopeResultsTitle = { fg = colors.bg1 },
    TelescopePreviewTitle = { bg = colors.green.bright, fg = colors.black.dim },
}

for hl, col in pairs(TelescopeColor) do
    vim.api.nvim_set_hl(0, hl, col)
end
