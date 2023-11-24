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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"tpope/vim-fugitive",
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				-- theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	{
		"mhartington/formatter.nvim",
	},
	{
		"ThePrimeagen/harpoon",
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		dependencies = {},
	},
	{
		"f-person/git-blame.nvim",
		dependencies = {},
	},
	{
		"folke/tokyonight.nvim",
		dependencies = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		dependencies = {},
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
})
