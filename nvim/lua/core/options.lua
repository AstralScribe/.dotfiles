local opt = vim.opt


-- line-numbers
opt.relativenumber = true
opt.number = true

-- tabbings and indentations
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = true

-- swap and backup
opt.swapfile = false
opt.backup = false

-- search-settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
-- opt.termguicolors = true
-- opt.background = "dark"
opt.signcolumn = "yes"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- cursor settings
-- opt.cursorline = true

-- keyword settings
opt.iskeyword:append("-")
opt.iskeyword:append("_")

