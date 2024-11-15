local status, ca = pcall(require, "clear-action")
if not status then
  return
end

ca.setup({
  signs = {
    enable = false,
    combine = false, -- combines all action kinds into a single sign
    position = "eol", -- "right_align" | "overlay"
    separator = " ", -- signs separator
    show_count = true, -- show the number of each action kind
    show_label = false, -- show the string returned by `label_fmt`
    label_fmt = function(actions) return actions[1].title end, -- actions is an array of `CodeAction`
    update_on_insert = false, -- show and update signs in insert mode
    icons = {
      quickfix = "🔧",
      refactor = "💡",
      source = "🔗",
      combined = "💡", -- used when combine is set to true
    },
    highlights = { -- highlight groups
      quickfix = "NonText",
      refactor = "NonText",
      source = "NonText",
      combined = "NonText",
      label = "NonText",
    },
  },
  popup = { -- remplaces the default prompt when selecting code actions
    enable = true,
    center = false,
    border = "rounded",
    highlights = {
      header = "CodeActionHeader",
      label = "CodeActionLabel",
      title = "CodeActionTitle",
    },
  },
  mappings = {
    -- The values can either be a string or a string tuple (with description)
    -- example: "<leader>aq" | { "<leader>aq", "Quickfix" }
    code_action = nil, -- a modified version of `vim.lsp.buf.code_action`
    apply_first = nil, -- directly applies the first code action
    -- These are just basically `vim.lsp.buf.code_action` with the `apply` option with some filters
    -- If there's only one code action, it gets automatically applied.
    quickfix = nil, -- can be filtered with the `quickfix_filter` option bellow
    quickfix_next = nil, -- tries to fix the next diagnostic
    quickfix_prev = nil, -- tries to fix the previous diagnostic
    refactor = nil,
    refactor_inline = nil,
    refactor_extract = nil,
    refactor_rewrite = nil,
    source = nil,
    -- server-specific mappings, server_name = {...}
    -- This is a map of code actions prefixes and keys
    actions = {
      -- example:
      -- ["rust_analyzer"] = {
      --   ["Inline"] = "<leader>ai"
      --   ["Add braces"] = { "<leader>ab", "Add braces" }
      -- }
    },
  },
  -- This is used for filtering actions in the quickfix functions
  -- It's a map of diagnostic codes and the preferred action prefixes
  -- You can check the diagnostic codes by hovering on the diagnostic
  quickfix_filters = {
    -- example:
    -- ["rust_analyzer"] = {
    --   ["E0433"] = "Import",
    -- },
    -- ["lua_ls"] = {
    --   ["unused-local"] = "Disable diagnostics on this line",
    -- },
  },
})
