vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            text = "",
            filetype = "NvimTree",
            highlight = "Directory",
        }}
    }
}
