require "nvchad.mappings"

local map = vim.keymap.set

map("i", "kj", "<Esc>l", { desc = "Exit Insert Mode and move right" })

map({ "n", "x", "o" }, "`", "0", { desc = "Go to start of line" })
map({ "n", "x", "o" }, "0", "$", { desc = "Go to end of line" })

map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo in Insert" })

map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo in Insert" })

map({ "n", "i" }, "<C-a>", "<Esc>ggVG", { desc = "Select All"})

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

