function ColorMyPencils(color)
	color = color or "PaperColor"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloatNormal", { bg = "none" })
end

ColorMyPencils()
