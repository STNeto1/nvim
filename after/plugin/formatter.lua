local util = require("formatter.util")

local biome = function()
	return {
		exe = "bunx",
		args = {
			"@biomejs/biome",
			"format",
			"--stdin-file-path",
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
	}
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		json = {
			require("formatter.defaults.prettierd"),
		},
		html = {
			require("formatter.defaults.prettierd"),
		},
		typescript = {
			biome,
		},
		typescriptreact = {
			require("formatter.defaults.prettierd"),
		},
		javascript = {
			require("formatter.defaults.biome"),
		},
		javascriptreact = {
			require("formatter.defaults.prettierd"),
		},
		go = {
			require("formatter.filetypes.go").goimports,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		graphql = {
			require("formatter.filetypes.graphql").prettierd,
		},
		svelte = {
			require("formatter.defaults.prettierd"),
		},
		astro = {
			require("formatter.defaults.prettierd"),
		},
		proto = {
			function()
				return {
					exe = "buf",
					args = {
						"format",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		ocaml = {
			function()
				return {
					exe = "ocamlformat",
					args = {
						"--enable-outside-detected-project",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- Automatically run :FormatWrite whenever a buffer is written
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.lua,*.go,*.rs,*.ts,*.tsx,*.json,*.graphql,*.ml,*.html,*.astro FormatWrite
augroup END
]],
	true
)
