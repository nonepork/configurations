return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    dependencies = {
        "HiPhish/rainbow-delimiters.nvim",
        "norcalli/nvim-colorizer.lua"
    }
}
