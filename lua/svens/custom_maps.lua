
-- Convenience remaps for navigation and diagnostics 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float)

-- Convenience maps for platformio
vim.keymap.set("n", "<leader>pu", ":!pio run -t upload<return>")
vim.keymap.set("n", "<leader>pb", ":!pio run<return>")
vim.keymap.set("n", "<leader>pd", ":!pio run -t compiledb<return>")

