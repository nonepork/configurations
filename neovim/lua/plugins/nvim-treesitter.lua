return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    dependencies = {
        "HiPhish/rainbow-delimiters.nvim",
        "brenoprata10/nvim-highlight-colors"
    }
}
