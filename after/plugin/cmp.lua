local cmp_format = function(opts)
  opts = opts or {}
  local maxwidth = opts.max_width or false

  local details = type(opts.details) == 'boolean' and opts.details or false

  local fields = details
    and {'abbr', 'kind', 'menu'}
    or {'abbr', 'menu', 'kind'}

  return {
    fields = fields,
    format = function(entry, item)
      local n = entry.source.name
      local label = ''

      if n == 'nvim_lsp' then
        label = '[LSP]'
      elseif n == 'nvim_lua'  then
        label = '[nvim]'
      else
        label = string.format('[%s]', n)
      end

      if details and item.menu ~= nil then
        item.menu =  string.format('%s %s', label, item.menu)
      else
        item.menu = label
      end

      if maxwidth and #item.abbr > maxwidth then
        local last = item.kind == 'Snippet' and '~' or ''
        item.abbr = string.format(
          '%s %s',
          string.sub(item.abbr, 1, maxwidth),
          last
        )
      end

      return item
    end,
  }
end

vim.o.pumheight = 10
local lspkind = require('lspkind')
local luasnip = require("luasnip")
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            --vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
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
        --{name = 'vsnip'},
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
    performance = {
        --max_view_entries = 8,
    },
})
