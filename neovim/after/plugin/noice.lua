require("noice").setup({
    views = {
        cmdline_popup = {
            border = {
                style = "none",
                padding = { 1, 3 },
            },
            position = {
                row = "30%",
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
            filter_options = {},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
    },
    cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
            cmdline = { pattern = "^:", icon = " ", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
            input = {},
        },
    },
})
