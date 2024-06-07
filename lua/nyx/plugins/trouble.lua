return {
	"folke/trouble.nvim",
	opts = {
		icons = {
			indent = {
				middle = " ",
				last = " ",
				top = " ",
				ws = "│  ",
			},
		},
		modes = {
			diagnostics = {
				groups = {
					{ "filename", format = "{file_icon} {basename:Title} {count}" },
				},
			},
			diagnostics_buffer = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = { buf = 0 }, -- filter diagnostics to the current buffer
			},
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("trouble").setup()
		--
		-- vim.keymap.set("n", "<leader>tt", function()
		-- 	trouble.toggle()
		-- end)
		--
		-- vim.keymap.set("n", "<leader>tn", function()
		-- 	trouble.next({ skip_groups = true, jump = true })
		-- end)
		--
		-- vim.keymap.set("n", "<leader>tp", function()
		-- 	trouble.previous({ skip_groups = true, jump = true })
		-- end)
	end,
	cmd = "Trouble",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>tl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
	},
}
