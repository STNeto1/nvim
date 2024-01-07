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

require("lazy").setup('nyx.plugins')

-- require("lazy").setup({
-- 	{ "williamboman/mason.nvim" },
-- 	{ "williamboman/mason-lspconfig.nvim" },
-- 	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
-- 	{ "neovim/nvim-lspconfig" },
-- 	{ "hrsh7th/cmp-nvim-lsp" },
-- 	{ "hrsh7th/nvim-cmp" },
-- 	{
-- 		"L3MON4D3/LuaSnip",
-- 		-- follow latest release.
-- 		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
-- 		-- install jsregexp (optional!).
-- 		build = "make install_jsregexp",
-- 	},
