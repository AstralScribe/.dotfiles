local mark_status, mark = pcall(require, "harpoon.mark")
if not mark_status then
	return
end

local ui_status, ui = pcall(require, "harpoon.ui")
if not ui_status then
	return
end

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
