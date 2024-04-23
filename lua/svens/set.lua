-- Options for line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Options for tabs, spacing, indents
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Options for neovim files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Options for searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Terminal options
vim.opt.termguicolors = true

-- Set view to offset from bottom and add indicator column at 80 characters
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"

-- Add sign column and allow @ in filenames
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Set update time
vim.opt.updatetime = 50

-- Set cursor behavior
vim.opt.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,n-i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- Set conceal level for obsidian plugin
vim.opt.conceallevel = 1
