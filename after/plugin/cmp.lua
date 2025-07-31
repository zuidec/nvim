vim.o.pumheight = 10
local lspkind = require('lspkind')
local luasnip = require("luasnip")
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
        completion = {
            cmp.config.window.bordered(),
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,CursorLine:PmenuSel",
            col_offset = -3,
            side_padding = 0,
            keyword_length = 3,
            scrollbar = true,
        },
        documentation = {
            cmp.config.window.bordered(),
            max_width = 50,
            max_height = 10,
        },
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip', option = {show_autosnippets = true} },
    },

    mapping = cmp.mapping.preset.insert({
        -- Luasnip super tab setup
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<CR>'] = cmp.mapping.confirm({select=false}),
        -- Remap the suggestion movements
        ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    }),
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function (entry, vim_item)
            local kind = require("lspkind").cmp_format({
                mode = 'symbol',
                maxwidth = {
                    menu = 50,
                    abbr = 50,
                },
                ellipsis_char = '...',
                show_labelDetails = true,
                before = function (entry, vim_item)
                    return vim_item
                end
            })(entry,vim_item)
            local strings = vim.split(kind.kind, "%s", {trimempty = true})
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },
})
