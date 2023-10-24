-- Import dap safely
local setup_dap, dap = pcall(require, "dap")
if not setup_dap then
  return
end

-- Import dap-ui safely
local setup_dapui, dapui = pcall(require, "dapui")
if not setup_dapui then
  return
end

-- Import dap safely
local setup_dappy, dappy = pcall(require, "dap-python")
if not setup_dappy then
  return
end

local setup_dapvt, dapvt = pcall(require, "nvim-dap-virtual-text")
if not setup_dapvt then
  return
end


-- dap-ui
dapui.setup()
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})

-- dap.
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- dap-python
local deubug_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
dappy.setup(deubug_path)

-- dap-virtual-text
dapvt.setup()
