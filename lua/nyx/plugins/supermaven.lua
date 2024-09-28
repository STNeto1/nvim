return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			ignore_filetypes = {},
			color = {
				suggestion_color = "#ffffff",
				cterm = 244,
			},
			log_level = "info", -- "info" | "off"
			disable_inline_completion = true, -- disables inline completion for use with cmp
		})
	end,
}
