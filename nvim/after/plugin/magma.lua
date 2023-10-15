local setup, magma = pcall(require, "magma")
if not setup then
  return
end

magma.setup({
  keys = {
    { "<leader>mi", "<cmd>MagmaInit<CR>", desc = "This command initializes a runtime for the current buffer." },
    { "<leader>mo", "<cmd>MagmaEvaluateOperator<CR>", desc = "Evaluate the text given by some operator." },
    { "<leader>ml", "<cmd>MagmaEvaluateLine<CR>", desc = "Evaluate the current line." },
    { "<leader>mv", "<cmd>MagmaEvaluateVisual<CR>", desc = "Evaluate the selected text." },
    { "<leader>mc", "<cmd>MagmaEvaluateOperator<CR>", desc = "Reevaluate the currently selected cell." },
    { "<leader>mr", "<cmd>MagmaRestart!<CR>", desc = "Shuts down and restarts the current kernel." },
    {
      "<leader>mx",
      "<cmd>MagmaInterrupt<CR>",
      desc = "Interrupts the currently running cell and does nothing if not cell is running.",
    },
  },
})

vim.g.nvim_set_var("magma_image_provider", "kitty")

