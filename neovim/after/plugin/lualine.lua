local lualine = require('lualine')

local custom_horizon = require('lualine.themes.horizon')

custom_horizon.normal.c.bg = nil
custom_horizon.insert.c.bg = nil
custom_horizon.visual.c.bg = nil
custom_horizon.replace.c.bg = nil
custom_horizon.command.c.bg = nil
custom_horizon.inactive.c.bg = nil

-- config
local config = {
    options = {
        theme = custom_horizon,
        component_separators = "",
        disabled_filetypes = {'NvimTree'},
    }
}

-- Now don't forget to initialize lualine
lualine.setup(config)
