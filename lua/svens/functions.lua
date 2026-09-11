require("svens.c_templates")
require("svens.md_templates")

vim.api.nvim_create_user_command('Cguard',

    function()
        C_headerguard()
    end,
    {nargs = 0, desc = 'Insert .h template with C style header guards'}
)

vim.api.nvim_create_user_command('Cmain',

    function()
        C_main()
    end,
    {nargs = 0, desc = 'Insert basic .c template with main()'}
)

vim.api.nvim_create_user_command('Cinfo',

    function()
        C_fileinfo()
    end,
    {nargs = 0, desc = 'Insert comment with file info at top'}
)

vim.api.nvim_create_user_command('Mrecipe',
    function()
        InsertRecipe()
    end,
    {nargs = 0, desc = 'Insert markdown recipe template at bottom of file'}
)
