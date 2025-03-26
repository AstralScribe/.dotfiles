local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end


-- local ccls_status, ccls = pcall(require, "ccls")
-- if not ccls_status then
--   return
-- end

local keymap = vim.keymap


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
lspconfig.ruff.setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      args = {},
    }
  }
}


lspconfig.pyright.setup({
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
lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- local ccls_config = {
--   cmd = { 'ccls' },
--   filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
--   root_dir = function(fname)
--     return lspconfig.util.root_pattern('compile_commands.json', '.ccls')(fname) or
--         lspconfig.util.find_git_ancestor(fname)
--   end,
--   offset_encoding = 'utf-32',
--   -- ccls does not support sending a null root directory
--   single_file_support = false,
--   docs = {
--     description = [[
-- https://github.com/MaskRay/ccls/wiki
--
-- ccls relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified
-- as compile_commands.json or, for simpler projects, a .ccls.
-- For details on how to automatically generate one using CMake look [here](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html). Alternatively, you can use [Bear](https://github.com/rizsotto/Bear).
--
-- Customization options are passed to ccls at initialization time via init_options, a list of available options can be found [here](https://github.com/MaskRay/ccls/wiki/Customization#initialization-options). For example:
--
-- ```lua
-- local lspconfig = require'lspconfig'
-- lspconfig.ccls.setup {
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   }
-- }
--
-- ```
--
-- ]],
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig.ccls.setup { ccls_config }

-- local util = lspconfig.util
-- local server_config = {
--   filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
--   root_dir = function(fname)
--     return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
--         or util.find_git_ancestor(fname)
--   end,
--   init_options = {
--     cache = {
--       directory = vim.fs.normalize "~/.cache/ccls"
--     }
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- ccls.setup {
--   lsp = {
--     lspconfig = server_config,
--     disable_capabilities = {
--       completionProvider = true,
--       documentFormattingProvider = true,
--       documentRangeFormattingProvider = true,
--       documentHighlightProvider = true,
--       documentSymbolProvider = true,
--       workspaceSymbolProvider = true,
--       renameProvider = true,
--       hoverProvider = true,
--       codeActionProvider = true,
--     },
--     disable_diagnostics = true,
--     disable_signature = true,
--   }
-- }

--------------------------- Web Development --------------------------------
-- configure html server
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure css server
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


--------------------------- JS Development --------------------------------
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

--------------------------- Go Development --------------------------------
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" }
})

----------------------------- Lua Development -----------------------------
lspconfig.lua_ls.setup({
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
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
}

----------------------------- Bash Development -----------------------------
lspconfig.bashls.setup {}
