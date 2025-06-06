local conform_status, conform = pcall(require, "conform")
if not conform_status then
  return
end

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    lua = { "stylua" },
    python = { "ruff_format" },
    cpp = { "clang-format" },
    ["_"] = { "trim_whitespace" },
  },
  formatters = {
    -- ["clang-format"] = { prepend_args = { "-style", "{BasedOnStyle: google, NamespaceIndentation: All}" } },
    ["clang-format"] = { prepend_args = { "-style", "{BasedOnStyle: google, Standard: c++20}" } },
    ["ruff_format"] = {}
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })
