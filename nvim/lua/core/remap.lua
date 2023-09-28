vim.g.mapleader = " "

local km = vim.keymap

-- file navigation
km.set("n", "<leader>pv", vim.cmd.Ex)

-- file quit
-- km.set("n", "<leader>q", ":q")
-- km.set("n", "<leader>w", ":w")
-- km.set("n", "<leader>wq", ":wq")
-- km.set("n", "<leader>qn", ":q!")


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

-- plugin keymaps

-- vim-maximizer
km.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
km.set("n", "<C-n>", ":NvimTreeToggle<CR>")


