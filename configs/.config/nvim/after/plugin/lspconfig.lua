local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end


-- local ccls_status, ccls = pcall(require, "ccls")
-- if not ccls_status then
--   return
-- end

local keymap = vim.keymap
local lspconfig = vim.lsp.config


local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set("n", "gf", "<cmd>Lspsaga finder def+ref<CR>", opts)
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

  if client.name == "ts_ls" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()



--------------------------- Python Development --------------------------------
lspconfig("ruff", {
  on_attach = on_attach,
  init_options = {
    settings = {
      args = {},
    }
  }
})


lspconfig("pyright", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pyright = { autoImportCompletion = true, },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off'
      }
    }
  }
})

-- lspconfig.pylsp.setup{}


-------------------------- C/C++ Development -------------------------------
lspconfig("clangd", {
  capabilities = capabilities,
  on_attach = on_attach,
})


--------------------------- Web Development --------------------------------
-- configure html server
lspconfig("html", {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure css server
lspconfig("cssls", {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig("tailwindcss", {
  capabilities = capabilities,
  on_attach = on_attach,
})


--------------------------- JS Development --------------------------------
lspconfig("emmet_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

--------------------------- Go Development --------------------------------
lspconfig("gopls", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" }
})

----------------------------- Lua Development -----------------------------
lspconfig("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

----------------------------- Rust Development -----------------------------
lspconfig("rust_analyzer", {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
})

----------------------------- Bash Development -----------------------------
lspconfig("bashls", {})
