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
	{ "rose-pine/neovim", name = "rose-pine" },
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
	-- "jamestthompson3/nvim-remote-containers",

	-- navigation
	"christoomey/vim-tmux-navigator", -- split windows and navigation
	"szw/vim-maximizer", -- maximize split window
	"nvim-tree/nvim-tree.lua", -- nvim tree

	-- tree-sitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- better editing
	"windwp/nvim-autopairs",
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",
	"numToStr/Comment.nvim", -- easy commenting for code
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- better markdown editors
	-- "junegunn/goyo.vim",
	-- "junegunn/limelight.vim",
	-- "folke/zen-mode.nvim",
	"folke/twilight.nvim",
	"Pocco81/true-zen.nvim",
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
	"nvim-lualine/lualine.nvim", -- status line
	"lewis6991/gitsigns.nvim", -- git change line
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

	-- debugger setup
	"mfussenegger/nvim-dap",
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	"theHamsta/nvim-dap-virtual-text",

	-- data science
	{
		"dccsillag/magma-nvim",
		version = "*",
		build = ":UpdateRemotePlugins",
		-- keys = {
		--   { "<leader>mi", "<cmd>MagmaInit<CR>", desc = "This command initializes a runtime for the current buffer." },
		--   { "<leader>mo", "<cmd>MagmaEvaluateOperator<CR>", desc = "Evaluate the text given by some operator." },
		--   { "<leader>ml", "<cmd>MagmaEvaluateLine<CR>", desc = "Evaluate the current line." },
		--   { "<leader>mv", "<cmd>MagmaEvaluateVisual<CR>", desc = "Evaluate the selected text." },
		--   { "<leader>mc", "<cmd>MagmaEvaluateOperator<CR>", desc = "Reevaluate the currently selected cell." },
		--   { "<leader>mr", "<cmd>MagmaRestart!<CR>", desc = "Shuts down and restarts the current kernel." },
		--   {
		--     "<leader>mx",
		--     "<cmd>MagmaInterrupt<CR>",
		--     desc = "Interrupts the currently running cell and does nothing if not cell is running.",
		--   },
		-- },
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
