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

-- indentation
vim.opt.smartindent = true
vim.opt.wrap = false

-- undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

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

-- check spelling
vim.opt.spelllang = "en_us" -- en_us, pt_br
vim.opt.spell = true

-- set this to dark or light
vim.opt.background = "dark"

-- set transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
