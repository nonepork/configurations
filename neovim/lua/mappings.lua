require "nvchad.mappings"

local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "n", "nzzzv")
map("n", "N", "nzzzv")
map("n", "<C-n>", "")

-- greatest remap here
map("x", "p", [["_dP]])
map({"n", "v"}, "y", [["+y]])
map("n", "Y", [["+Y]])
map({"n", "v"}, "d", [["_d]])

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Find & Replace all current word" })
map("v", "<leader>s", [[y:%s/\<<C-r>"\>/<C-r>"/gI<Left><Left><Left>]], {desc = "Find & Replace all selected text" })

-- nvimgrass
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- tabufufufu
map("n", "<S-c>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- telephone
map("n", "<leader>fg", "<cmd> Telescope live_grep<CR>", { desc = "telescope live grep" })

----------------------------

local nomap = vim.keymap.del

nomap("n", "<C-n>")

-- terminal
nomap("t", "<C-x>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap({"n", "t"}, "<A-v>")
nomap({"n", "t"}, "<A-h>")
nomap({"n", "t"}, "<A-i>")
nomap("i", "<C-b>")
nomap("i", "<End>")
nomap("n", "<leader>x")
nomap("n", "<leader>fw")
