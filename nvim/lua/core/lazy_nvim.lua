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

require("lazy").setup({
    "nvim-lua/plenary.nvim",
	"rebelot/kanagawa.nvim", -- theme
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'rose-pine/neovim', name = 'rose-pine' },
    -- tree-sitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"windwp/nvim-autopairs",

    "ThePrimeagen/vim-be-good",
    "christoomey/vim-tmux-navigator", -- split windows and navigation
    "szw/vim-maximizer", -- maximize split window
    "tpope/vim-surround",
    "vim-scripts/ReplaceWithRegister",
    "numToStr/Comment.nvim", -- easy commenting for code
    "nvim-tree/nvim-tree.lua", -- nvim tree
    "junegunn/goyo.vim", -- focused writing
    "junegunn/limelight.vim",
    "nvim-tree/nvim-web-devicons", -- nvim tree icons
    "nvim-lualine/lualine.nvim", -- status line
    "lewis6991/gitsigns.nvim",

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
    {"glepnir/lspsaga.nvim", branch = "main"},
    "onsails/lspkind.nvim",

    -- data science

    {
        "dccsillag/magma-nvim",
        version = "*",
        build = ":UpdateRemotePlugins",
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
    },
})