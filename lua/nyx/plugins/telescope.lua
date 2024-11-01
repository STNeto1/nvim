return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		-- local theme = require("telescope.themes")
		-- local telescopeConfig = require("telescope.config")

		-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
		-- -- I want to search in hidden/dot files.
		-- table.insert(vimgrep_arguments, "--hidden")
		-- -- I don't want to search in the `.git` directory.
		-- table.insert(vimgrep_arguments, "--glob")
		-- table.insert(vimgrep_arguments, "!**/.git/*")
		--
		telescope.setup({
			-- defaults = {
			-- 	-- `hidden = true` is not supported in text grep commands.
			-- 	vimgrep_arguments = vimgrep_arguments,
			-- },
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})
		--
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[?] Find files in the project " })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "[?] Find references" })
		vim.keymap.set("n", "<leader>fl", builtin.live_grep, {
			desc = "[?] Search for a string in your current working directory and get results live as you type, respects .gitignore.",
		})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {
			desc = "[?] Searches for the string under your cursor or selection in your current working directory",
		})
		vim.keymap.set("n", "<leader>gs", builtin.git_files, {
			desc = "[?] Fuzzy search through the output of git ls-files command, respects .gitignore",
		})

		--       vim.keymap.set("n", "<leader>F", function()
		-- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(theme.get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, {
			desc = "[?] Lists LSP document symbols in the current buffer",
		})

		vim.keymap.set("n", "<leader>fD", builtin.lsp_definitions, {
			desc = "[?] Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
		})
	end,
}
