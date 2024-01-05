vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            text = "File Tree",
            filetype = "NvimTree",
            highlight = "Directory",
        }}
    }
}
