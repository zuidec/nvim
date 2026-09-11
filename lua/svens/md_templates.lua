function InsertRecipe()
    vim.api.nvim_buf_set_lines(0, -1, -1, true, {
        "",
        "# [Home](home.md)",
        "# [[recipes|Recipe Main]]",
        "",
        "---",
        "",
        "# ",
        "",
        "Description:",
        ">",
        "",
        "## Ingredients",
        "",
        "-",
        "",
        "",
        "## Directions",
        "",
        "1.",
    })
end
