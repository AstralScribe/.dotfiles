vim.g.mapleader = " "
local km = vim.keymap

-- --------------------------- Essential Mappings ---------------------------
-- file navigation
km.set("n", "<leader>pv", vim.cmd.Ex)

-- general keymaps
km.set("i", "qw", "<ESC>")
km.set("n", "<leader>cs", ":nohl<CR>")
km.set("n", "x", '"_x')

-- inc/dec numbers
km.set("n", "<leader>=", "<C-a>")
km.set("n", "<leader>-", "<C-x>")

-- windows splitting 
km.set("n", "<leader>sh", "<C-w>s")
km.set("n", "<leader>sv", "<C-w>v")
km.set("n", "<leader>se", "<C-w>=")
km.set("n", "<leader>sx", ":close<CR>")

-- window tabs
km.set("n", "<leader>tn", ":tabnew<CR>")
km.set("n", "<leader>tx", ":tabclose<CR>")
km.set("n", "<leader>t[", ":tabp<CR>")
km.set("n", "<leader>t]", ":tabn<CR>")


-- --------------------------- PLUGIN Mappings ---------------------------
-- vim-maximizer
km.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
km.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- zen-mode
km.set("n", "<leader>z", ":ZenMode<CR>")

-- lsp-saga
-- km.set("n", "<leader>h", "<cmd>Lspsaga term_toggle<CR>")

-- Fterm
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')







