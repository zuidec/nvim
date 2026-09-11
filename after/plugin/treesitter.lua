local ts = require('nvim-treesitter')

-- A list of parser names, or "all" (the five listed parsers should always be installed)
ts.install{
      "vimdoc", "javascript", "markdown", "markdown_inline", "php",
      "html", "c", "cpp", "lua", "vim", "vimdoc", "query", "latex",
      "yaml"
  }

vim.api.nvim_create_autocmd('FileType', {
     callback = function()
         pcall(vim.treesitter.start)
     end,
})

