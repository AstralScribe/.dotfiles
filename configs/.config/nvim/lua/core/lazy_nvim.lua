local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {

  --themes
  "rebelot/kanagawa.nvim",
  { "rose-pine/neovim",                name = "rose-pine" },
  "Rigellute/shades-of-purple.vim",

  -- essential plugins
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "tpope/vim-obsession",
  "folke/trouble.nvim",
  "ThePrimeagen/harpoon",
  -- "jamestthompson3/nvim-remote-containers",
  "t-troebst/perfanno.nvim",

  -- navigation
  "christoomey/vim-tmux-navigator", -- split windows and navigation
  "szw/vim-maximizer",              -- maximize split window
  "nvim-tree/nvim-tree.lua",        -- nvim tree

  -- tree-sitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- better editing
  "windwp/nvim-autopairs",
  "tpope/vim-surround",
  "vim-scripts/ReplaceWithRegister",
  "numToStr/Comment.nvim", -- easy commenting for code
  "anuvyklack/pretty-fold.nvim",
  -- {
  -- 	"folke/noice.nvim",
  -- 	event = "VeryLazy",
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		"rcarriga/nvim-notify",
  -- 	},
  -- },

  -- better markdown editors
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- editor beautification
  "nvim-tree/nvim-web-devicons", -- nvim tree icons
  "DaikyXendo/nvim-material-icon",
  "nvim-lualine/lualine.nvim",   -- status line
  "lewis6991/gitsigns.nvim",     -- git change line
  "tpope/vim-fugitive",
  "luckasRanarison/clear-action.nvim",

  -- auto-completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- lsp management
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "nvimdev/lspsaga.nvim",
  "onsails/lspkind.nvim",
  "jose-elias-alvarez/typescript.nvim",
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  "fatih/vim-go",
  "Civitasv/cmake-tools.nvim",


  -- debugger setup
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      handler = {}
    }
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- extras
  "ThePrimeagen/vim-be-good",
  "edluffy/hologram.nvim",
  "numToStr/FTerm.nvim",
}

local opts = {
  -- defaults = {
  -- 	lazy = true,
  -- },
}

require("lazy").setup(plugins, opts)
