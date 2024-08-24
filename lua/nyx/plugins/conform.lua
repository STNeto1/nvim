return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports" },
				rust = { "rustfmt", lsp_format = "fallback" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				javascript = { "biome" },
				sql = { "sleek" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true })
		end, { desc = "Format code" })
	end,
}
