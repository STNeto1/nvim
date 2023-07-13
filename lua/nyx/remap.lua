-- Set space as leader key
vim.g.mapleader = " "

-- Remap to "home"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allow to move selected line(s)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap to "end"
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered when half page scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Put yank text in system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Remove Q mapping
vim.keymap.set("n", "Q", "<nop>")

-- Format with f
vim.keymap.set("n", "f", function()
  vim.lsp.buf.format()
end)
