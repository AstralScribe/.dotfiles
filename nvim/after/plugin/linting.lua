local lint_status, lint = pcall(require, "lint")
if not lint_status then
	return
end

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	python = { "ruff" },
	cpp = { "cpplint" },
}

local cpplint = lint.linters.cpplint
cpplint.args = { "--filter", "-legal/copyright,-runtime/indentation_namespace" }

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>l", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
