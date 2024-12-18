-- Set space as leader key
vim.g.mapleader = " "

-- Remap to "home"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Keep cursor centered when half page scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Put yank text in system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Copy whole block
vim.keymap.set("n", "Y", "yVaB")

-- Remap to macros
vim.keymap.set("n", "Q", "@qj")

-- Remap to macros
vim.keymap.set("x", "Q", ":norm @q<CR>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Paste and replace
vim.keymap.set("n", "P", "VP")

-- Next/previous item on ccl
vim.keymap.set("n", "<leader>cn", ":cn<CR>")
vim.keymap.set("n", "<leader>cp", ":cp<CR>")
vim.keymap.set("n", "<leader>cc", ":ccl<CR>")
