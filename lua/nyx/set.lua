-- gui cursor
-- vim.opt.guicursor = ""

-- line numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- identation
vim.opt.smartindent = true
vim.opt.wrap = false

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- terminal colors
vim.opt.termguicolors = true

-- will always have 8 lines above and below the cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"
