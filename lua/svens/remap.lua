vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pp", "*p")
vim.keymap.set("n", "<leader>yy", "*y")
vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>pu", ":!pio run -t upload<return>")
vim.keymap.set("n", "<leader>pb", ":!pio run<return>")
