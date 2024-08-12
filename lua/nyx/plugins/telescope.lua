return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local theme = require("telescope.themes")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[?] Find files in the project " })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "[?] Find references" })
		vim.keymap.set("n", "<leader>fl", builtin.live_grep, {
			desc = "[?] Search for a string in your current working directory and get results live as you type, respects .gitignore.",
		})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {
			desc = "[?] Searches for the string under your cursor or selection in your current working directory",
		})
		vim.keymap.set("n", "<leader>F", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(theme.get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, {
			desc = "[?] Lists LSP document symbols in the current buffer",
		})
		vim.keymap.set("n", "<leader>fD", builtin.lsp_definitions, {
			desc = "[?] Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
		})
	end,
}
