function ColorsSch(color)
	color = color or "kanagawa"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = "none"})
  vim.api.nvim_set_hl(0, 'LineNr', { bg = "none"})
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = "none"})
end

ColorsSch()

