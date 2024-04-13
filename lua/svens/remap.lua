-- Set leader to space
vim.g.mapleader = " "

-- Copy and cut keymaps to system clipboard
vim.keymap.set("v", "<C-c>", "+y")
vim.keymap.set("n", "<C-c>", "+y$")
vim.keymap.set("v", "<C-x>", "+d")
vim.keymap.set("n", "<C-x>", "+d$")

-- Set register for put and yank
vim.keymap.set("n", "<leader>pp", "*p")
vim.keymap.set("n", "<leader>yy", "*y")
