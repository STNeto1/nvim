return {
	"lvimuser/lsp-inlayhints.nvim",
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
}
