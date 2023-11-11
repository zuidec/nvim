function Addguard()
    -- Inserts C style header guards into top and bottom of file    
    local filename = vim.fn.expand('%:t')
    filename = string.upper(filename)
    filename = string.gsub(filename, "%.", "_")

    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        "#ifndef " .. filename,
        "#define " .. filename,
        ""
    })
    vim.api.nvim_buf_set_lines(0, -1, -1, true, {"#endif",""})
end

function Ctemplate()
    -- Inserts a basic template with a main() function
    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        "",
        "int main(int argc, char* argv[])   { ",
        "",
        "   return 0;",
        "}"
    })
end
