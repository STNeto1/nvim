
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
		typescript = {
			require("formatter.defaults.prettierd"),
		},
		typescriptreact = {
			require("formatter.defaults.prettierd"),
		},
		go = {
			require("formatter.filetypes.go").goimports,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
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
-- vim.api.nvim_exec([[
-- augroup FormatAutogroup
-- autocmd!
-- autocmd BufWritePost *.astro,*.ts,*.tsx,*.mjs,*.js,*.jsx,*.json,*.graphql FormatWrite
-- augroup END
-- ]], true)
