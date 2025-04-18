require("markview").setup {
  opts = {
    preview = {
      icon_provider = "devicons",
      filetypes = {
        "md",
        "markdown",
        "norg",
        "rmd",
        "org",
        "vimwiki",
        "typst",
        "latex",
        "quarto",
        "Avante",
        "codecompanion",
      },
      ignore_buftypes = {},

      condition = function(buffer)
        local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt

        if bt == "nofile" and ft == "codecompanion" then
          return true
        elseif bt == "nofile" then
          return false
        else
          return true
        end
      end,
    },
  },
}

require("markview.extras.checkboxes").setup {
  --- Default checkbox state(used when adding checkboxes).
  ---@type string
  default = "X",

  --- Changes how checkboxes are removed.
  ---@type
  ---| "disable" Disables the checkbox.
  ---| "checkbox" Removes the checkbox.
  ---| "list_item" Removes the list item markers too.
  remove_style = "disable",

  --- Various checkbox states.
  ---
  --- States are in sets to quickly change between them
  --- when there are a lot of states.
  ---@type string[][]
  states = {
    { " ", "/", "X" },
    { "<", ">" },
    { "?", "!", "*" },
    { '"' },
    { "l", "b", "i" },
    { "S", "I" },
    { "p", "c" },
    { "f", "k", "w" },
    { "u", "d" },
  },
}
