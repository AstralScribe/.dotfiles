local status, trouble = pcall(require, "trouble.nvim")
if not status then
	return
end

trouble.setup()
