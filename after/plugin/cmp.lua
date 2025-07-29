local cmp = require('cmp')
--local cmp_format = require('lsp-zero').cmp_format()
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
