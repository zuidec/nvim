require("svens.c_templates")

vim.api.nvim_create_user_command('Cguard',

    function()
        Addguard()
    end,
    {nargs = 0, desc = 'Add C style header guards'}
)

vim.api.nvim_create_user_command('Cmain',

    function()
        Ctemplate()
    end,
    {nargs = 0, desc = 'Add C style header guards'}
)
