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
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true })

-- Eval under cursor
vim.keymap.set("n", "<leader>?", function()
  dapui.eval(nil, { enter = true })
end)


-- dap.
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- dap-python
local deubug_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
dappy.setup(deubug_path)


-- dap-cpp
dap.configurations.cpp = {
  {
    name = "Debug using codelldb",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

-- dap-virtual-text
dapvt.setup()

-- Debug Keybindings
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)
