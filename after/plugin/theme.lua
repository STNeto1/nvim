vim.opt.background = "dark" -- set this to dark or light
-- Set colorscheme after options
vim.cmd("colorscheme tokyonight-night")

-- Set background to transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
