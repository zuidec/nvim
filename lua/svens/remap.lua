-- Set leader to space
vim.g.mapleader = " "

-- Copy and cut keymaps to system clipboard
vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-c>", "\"+y$")
vim.keymap.set("v", "<C-x>", "\"+d")
vim.keymap.set("n", "<C-x>", "\"+d$")

-- Set register for put and yank
vim.keymap.set("n", "<leader>p", "\"*p")
vim.keymap.set("n", "<leader>yy", "\"*y$")
vim.keymap.set("v", "<leader>p", "\"*p")
vim.keymap.set("v", "<leader>y", "\"*y")

-- Set LSP keymaps
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
