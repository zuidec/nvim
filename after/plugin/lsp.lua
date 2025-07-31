local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua config
vim.lsp.config('luals', {
    cmd = {'lua-language-server'},
    capabilities = capabilities,
    filetypes = {'lua'},
    root_markers = { '.luarc.json', '.luarc.jsonc'},
})
vim.lsp.enable('luals')

-- Clangd config
vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = {
        "clangd",
        -- Uncomment to stop function argument placeholders from being used
        --"--function-arg-placeholders=0",
        --"--header-insertion=never",
        "--header-insertion-decorators",
    },
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
        "proto",
    },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git',
    },
    single_file_support = true,
})
vim.lsp.enable('clangd')

-- Markdown config
vim.lsp.config('marksman', {
    cmd = {'marksman'},
    capabilities = capabilities,
    filetypes = {'md'},
    root_markers = {'.marksman.toml'},
})
vim.lsp.enable('marksman')
