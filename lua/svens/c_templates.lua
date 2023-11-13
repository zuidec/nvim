-- user variable to print into templates
local user = "zuidec"

function C_headerguard()
    -- Inserts C style header guards into top and bottom of file    
    local filename = vim.fn.expand('%:t')
    filename = string.upper(filename)
    filename = string.gsub(filename, "%.", "_")
    
    local info_size = C_fileinfo()

    vim.api.nvim_buf_set_lines(0, info_size, info_size, true, {
        "",
        "#ifndef " .. filename,
        "#define " .. filename .. "\t// BEGIN " .. filename,
        "",
        "/*",
        " *\tIncludes",
        " */",
        "",
        "",
        "",
        "/*",
        " *\tDefines",
        " */",
        "",
        "",
        "",
        "/*",
        " *\tStructs, unions, etc...",
        " */",
        "",
        "",
        "",
        "/*",
        " *\tFunction prototypes",
        " */",
        "",
        "",
        ""
    })
    vim.api.nvim_buf_set_lines(0, -1, -1, true, {"#endif\t// END " .. filename})
end

function C_main()
    -- Inserts a basic template with a main() function
    
    local info_size = C_fileinfo()
    
    vim.api.nvim_buf_set_lines(0, info_size, info_size, true, {
        "",
        "int main(int argc, char* argv[])   { ",
        "",
        "   return 0;",
        "}"
    })
end

function C_fileinfo()

    -- Inserts comment at the top of file with name, date
    local filename = vim.fn.expand('%:t')
    
    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        "/*",
        " *\t" .. filename,
        " *\t(enter file description here)",
        " *",
        " *\tCreated by " .. user .. " on " .. os.date('%D'),
        " */"
    })
    return 6
end
