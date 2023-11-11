local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({

    sources = {
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
    },

    mapping = cmp.mapping.preset.insert({

        -- Allow using enter to confirm selection
        ['<CR>'] = cmp.mapping.confirm({select=false}),

        -- Remap the suggestion movements
        ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    }),

    formatting = cmp_format,
})
