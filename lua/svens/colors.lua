local M = {}

function M.set_color(color)
--	color = color or "PaperColor"
    color = color or "evergarden"

    if color == 'evergarden' then
        local evergarden= require("svens.evergarden_config")
        evergarden.custom_setup()
    else
        vim.cmd.colorscheme(color)
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloatNormal", { bg = "none" })
    end
end

return M
