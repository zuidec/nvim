local M = {}

M.evergarden_config = {
      theme = {
        variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
        accent = 'green',
      },
      editor = {
        transparent_background = true,
        override_terminal = true,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          solid_border = false,
        },
        completion = {
          color = 'surface0',
        },
      },
      style = {
        tabline = { 'reverse' },
        search = { 'italic', 'reverse' },
        incsearch = { 'italic', 'reverse' },
        types = { 'italic' },
        keyword = { 'italic' },
        comment = { 'italic' },
      },
      overrides = {
            --Normal = { bg = "none" },
            --NormalFloatNormal = { bg = "none" },
      },
      color_overrides = {},
}

function M.custom_setup(opts)
    if opts ~= nil then
        require("evergarden").setup(opts)
    else
        require("evergarden").setup(M.evergarden_config)
    end
    vim.cmd.colorscheme('evergarden')
end

return M
