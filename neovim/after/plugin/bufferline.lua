vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            text = "", -- Title text of nvimtree
            filetype = "NvimTree",
            highlight = "Directory",
        }}
    }
}
