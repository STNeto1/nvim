local api = require("nvim-tree.api")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>t", api.tree.toggle)

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	-- on_attach = on_attach,
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})
