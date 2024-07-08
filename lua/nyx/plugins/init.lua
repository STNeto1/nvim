return {
	"lvimuser/lsp-inlayhints.nvim",
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = true,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
}
