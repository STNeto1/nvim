local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()

local lsp_zero = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

cmp.setup({
	formatting = cmp_format,
	sources = {
		{ name = "nvim_lsp" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

lsp_zero.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "»",
	},
})

lsp_zero.on_attach(function(_, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })

	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader><F2>", vim.lsp.buf.rename, "Rename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("<leader>vd", vim.diagnostic.open_float, "Open Diagnostics")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("K", vim.lsp.buf.hover, "Hover")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

	nmap("<leader>rr", vim.lsp.buf.references, "[R]erefences")

	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
end)

-- inlayhints
local ih = require("lsp-inlayhints")
local lsp_cfg = require("lspconfig")
ih.setup({
	{
		inlay_hints = {
			parameter_hints = {
				show = true,
				prefix = "<- ",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = true,
			},
			type_hints = {
				-- type and other hints
				show = true,
				prefix = "",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = false,
			},
			only_current_line = false,
			-- separator between types and parameter hints. Note that type hints are
			-- shown before parameter
			labels_separator = "  ",
			-- whether to align to the length of the longest line in the file
			max_len_align = false,
			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,
			-- highlight group
			highlight = "LspInlayHint",
			-- virt_text priority
			priority = 0,
		},
		enabled_at_startup = true,
		debug_mode = false,
	},
})
lsp_cfg.tsserver.setup({
	on_attach = function(client, bufnr)
		ih.on_attach(client, bufnr)
	end,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})
lsp_cfg.gopls.setup({
	on_attach = function(client, bufnr)
		ih.on_attach(client, bufnr)
	end,
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				unreachable = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

lsp_zero.setup()
