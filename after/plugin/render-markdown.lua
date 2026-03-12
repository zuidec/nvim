local rendermarkdown = require('render-markdown')

vim.api.nvim_set_hl(0, 'CustomWarning', {fg = '#a8752f', italic = true } )
vim.api.nvim_set_hl(0, 'CustomCancel', {fg = '#b1402a'} )
vim.api.nvim_set_hl(0, 'CustomQuestion', {fg = '#378ab1'} )
vim.api.nvim_set_hl(0, 'CustomForwarded', {fg = '#7da0a8'} )
vim.api.nvim_set_hl(0, 'CustomIncomplete', {fg = '#fefea4'} )
vim.api.nvim_set_hl(0, 'CustomComplete', {fg = '#364c35'} )
vim.api.nvim_set_hl(0, 'CustomCompleteStrikethrough', {fg = '#364c35', strikethrough = true} )

rendermarkdown.setup({

    file_types = {'markdown'},
    -- Allow rendering when in insert mode as well as other modes
    render_modes = true,

    heading = {
        -- The symbol by the line number
        sign = false,
        -- Sets the highlighted portion to only the text
        width = 'block',
        left_pad = 2,
        right_pad = 4,
    },

    checkbox = {
        -- Turn on / off checkbox state rendering.
        enabled = true,

        -- Additional modes to render checkboxes.
        render_modes = true,

        -- Render the bullet point before the checkbox.
        bullet = false,

        -- Padding to add to the left of checkboxes.
        left_pad = 0,

        -- Padding to add to the right of checkboxes.
        right_pad = 1,
        unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'.
            icon = '󰄱 ',
            -- Highlight for the unchecked icon.
            highlight = 'RenderMarkdownUnchecked',
            -- Highlight for item associated with unchecked checkbox.
            scope_highlight = nil,
        },
        checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'.
            --icon = '󰱒 ',
            -- Highlight for the checked icon.
            highlight = 'CustomComplete',
            -- Highlight for item associated with checked checkbox.
            scope_highlight = 'CustomCompleteStrikethrough',
        },

        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰜺', highlight = 'CustomCancel', scope_highlight = 'CustomCancel'},
            incomplete = { raw = '[/]', rendered = '󰡖', highlight = 'CustomIncomplete', scope_highlight = 'CustomIncomplete'},
            important = { raw = '[!]', rendered = '', highlight = 'CustomWarning', scope_highlight =  'CustomWarning'},
            forward = { raw = '[>]', rendered = '', highlight = 'CustomForwarded', scope_highlight = nil },
            question = { raw = '[?]', rendered = '', highlight = 'CustomQuestion', scope_highlight = nil },
        },

        -- Priority to assign to scope highlight.
        scope_priority = nil,
    },
    latex = {
        enabled = true,
        render_modes = false,
        converter = { 'utftex', 'latex2text' },
        highlight = 'RenderMarkdownMath',
        position = 'center',
        top_pad = 1,
        bottom_pad = 1,
    },
    code = {
        style = 'normal',
        width = 'block',
        left_pad = 2,
        right_pad = 4,
    },
})
