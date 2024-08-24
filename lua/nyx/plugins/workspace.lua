return {
	"stneto1/workspace.nvim",
	dir = "~/oss/workspace.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		local ws = require("workspace")

		ws.setup({
			workspaces = {
				{ name = "Apps", path = { "~/apps", "~/work", "~/programming", "~/oss" }, keymap = { "<leader>ta" } },
			},
			tmux_session_name_generator = function(project_name, _)
				return project_name
			end,
		})

		vim.keymap.set("n", "<leader>ts", ws.tmux_sessions)
	end,
}
