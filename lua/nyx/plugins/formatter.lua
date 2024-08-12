return {
	"mhartington/formatter.nvim",
	config = function()
		local util = require("formatter.util")

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				sql = {
					function()
						return {
							exe = "sleek",
							args = {
								util.escape_path(util.get_current_buffer_file_path()),
							},
							stdin = false,
						}
					end,
				},
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				json = {
					require("formatter.defaults.biome"),
				},
				html = {
					require("formatter.defaults.biome"),
				},
				typescript = {
					require("formatter.defaults.biome"),
				},
				typescriptreact = {
					require("formatter.defaults.biome"),
				},
				javascript = {
					require("formatter.defaults.biome"),
				},
				astro = {
					require("formatter.defaults.biome"),
				},
				go = {
					require("formatter.filetypes.go").goimports,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				graphql = {
					require("formatter.filetypes.graphql").biome,
				},
				yaml = {
					require("formatter.filetypes.yaml").yamlfmt,
				},

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				-- ["*"] = {
				-- 	-- "formatter.filetypes.any" defines default configurations for any
				-- 	-- filetype
				-- 	-- require("formatter.filetypes.any").remove_trailing_whitespace,
				--
				-- 	-- -- code to use default lsp formatter if nothing matched before
				-- 	-- -- its not good because it lags a lot
				-- 	function()
				-- 		-- Ignore already configured types.
				-- 		local defined_types = require("formatter.config").values.filetype
				-- 		if defined_types[vim.bo.filetype] ~= nil or vim.bo.filetype == "make" then
				-- 			return nil
				-- 		end
				-- 		vim.lsp.buf.format({ async = true })
				-- 	end,
				-- },
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
	end,
}
