return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[?] Find files in the project " })
		vim.keymap.set("n", "<leader>fr", builtin.live_grep, {
			desc = "[?] Search for a string in your current working directory and get results live as you type, respects .gitignore.",
		})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {
			desc = "[?] Searches for the string under your cursor or selection in your current working directory",
		})

		-- vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
		-- vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
		-- vim.keymap.set('n', '<leader>/', function()
		--   -- You can pass additional configuration to telescope to change theme, layout, etc.
		--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		--     winblend = 10,
		--     previewer = false,
		--   })
		-- end, { desc = '[/] Fuzzily search in current buffer' })
	end,
}
