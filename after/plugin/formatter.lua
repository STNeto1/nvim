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
			biome,
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
			biome,
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
		elixir = {
			require("formatter.filetypes.elixir").mixformat,
		},
		heex = {
			function()
				return {
					exe = "mix",
					args = {
						"format",
					},
					stdin = false,
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

			-- -- code to use default lsp formatter if nothing matched before
			-- -- its not good because it lags a lot
			-- function()
			-- 	-- Ignore already configured types.
			-- 	local defined_types = require("formatter.config").values.filetype
			-- 	if defined_types[vim.bo.filetype] ~= nil then
			-- 		return nil
			-- 	end
			-- 	vim.lsp.buf.format({ async = true })
			-- end,
		},
	},
})

-- Automatically run :FormatWrite whenever a buffer is written
vim.api.nvim_exec(
	[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]],
	true
)
