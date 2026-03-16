vim.opt.termguicolors = true -- full terminal color support

-- ======
-- Options
-- ======
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line number
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- line wrap by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines left/right cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- ident witdh
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace ??
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case insensitive if uppercase is string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always shows sign column
vim.opt.colorcolumn = "120" -- show color column at position N

vim.opt.showmatch = true -- highlight matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it on statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- windows menu transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlight limit
vim.opt.fillchars = { eob = " " } -- hide ~ on empty lines

-- No idea if i like it, but im testing
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p") -- create if not exist
end

vim.opt.backup = false -- no backup files
vim.opt.writebackup = false -- no not write backup files
vim.opt.swapfile = false -- do not create .swp files
vim.opt.undofile = true -- create undo file
vim.opt.undodir = undodir -- set the undo dir
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-write

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sound
vim.opt.backspace = "indent,eol,start" -- better backspace behavior
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- text encoding

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ======
-- Keymaps
-- ======
vim.g.mapleader = " " -- space as the leader
vim.g.maplocalleader = " " -- space as the leader

vim.g.have_nerd_font = true -- nerd font support

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostics message" })
vim.keymap.set("n", "<leader>]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostics message" })

vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror message" })
vim.keymap.set("n", "<leader>t", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>[q", vim.cmd.cp, { desc = "Go to previous quickfix list item" })
vim.keymap.set("n", "<leader>]q", vim.cmd.cn, { desc = "Go to next quickfix list item" })
vim.keymap.set("n", "<leader>[[", vim.cmd.cclose, { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>]]", vim.cmd.copen, { desc = "Open quickfix list" })

-- ======
-- Autocmd
-- ======
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- ======
-- Plugins
-- ======
vim.pack.add({
	"https://github.com/dmtrKovalenko/fff.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/loctvl842/monokai-pro.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",

	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",

	"https://github.com/kdheepak/lazygit.nvim",

	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/rafamadriz/friendly-snippets",
})

--- === COLORSCHEME ===
require("monokai-pro").setup({
	transparent_background = false,
	terminal_colors = true,
	devicons = true,
	styles = {
		comment = { italic = true },
		keyword = { italic = true },
		type = { italic = true },
		storageclass = { italic = true },
		structure = { italic = true },
		parameter = { italic = true },
		annotation = { italic = true },
		tag_attribute = { italic = true },
	},
	filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
	day_night = {
		enable = false,
		day_filter = "pro",
		night_filter = "spectrum",
	},
	inc_search = "background", -- underline | background
	background_clear = {
		"toggleterm",
		"telescope",
		"renamer",
		"notify",
	},
	plugins = {
		bufferline = {
			underline_selected = false,
			underline_visible = false,
			underline_fill = false,
			bold = true,
		},
		indent_blankline = {
			context_highlight = "default", -- default | pro
			context_start_underline = false,
		},
	},
	override = function(scheme)
		return {}
	end,
	override_palette = function(filter)
		return {}
	end,
	override_scheme = function(scheme, palette, colors)
		return {}
	end,
})
vim.cmd("colorscheme monokai-pro")
require("lualine").setup({
	options = { theme = "monokai-pro" },
})

--- === FFF ===
require("fff").setup({
	base_path = vim.fn.getcwd(),
	prompt = "🪿 ",
	title = "FFFiles",
	max_results = 100,
	max_threads = 4,
	lazy_sync = true, -- set to false if you want file indexing to start on open
	debug = {
		enabled = true,
		show_scores = true,
	},
})

vim.keymap.set("n", "sf", function()
	require("fff").find_files()
end, { desc = "FFFind files" })

vim.keymap.set("n", "sg", function()
	require("fff").live_grep()
end, { desc = "LiFFFe grep" })

-- === TREESITTER ===
vim.cmd("packadd nvim-treesitter")
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	highlight = { enable = true },
	indent = { enable = true },
})

-- === MASON ===
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- === FORMATTER ===
require("conform").setup({
	notify_on_error = true,
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		python = { "ruff" },
		go = { "goimports" },
		typescript = { "local_oxfmt" },
		typescriptreact = { "local_oxfmt" },
		json = { "local_oxfmt" },
		sql = { "sleek" },
		toml = { "taplo" },
		yaml = { "yamlfmt" },
		terraform = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
	},
})
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- === LSP ===
vim.cmd("packadd lazydev.nvim")
require("lazydev.config").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

for _, svr_name in ipairs({
	"gopls",
	"tsgo",
	"rust_analyzer",
	"oxlint",
	"stylua",
}) do
	vim.lsp.enable(svr_name)

	vim.lsp.config(svr_name, {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})
end

vim.cmd("packadd telescope.nvim")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
		end
		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")
		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")
		map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	end,
})

vim.cmd("packadd blink.cmp")
require("blink.cmp").setup({
	fuzzy = {
		prebuilt_binaries = { download = true },
		implementation = "lua",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		-- menu = { border = 'single' },
		menu = {
			draw = {
				padding = { 0, 1 }, -- padding only on right side
				components = {
					kind_icon = {
						text = function(ctx)
							return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
						end,
					},
				},
			},
		},
		documentation = { auto_show = true, treesitter_highlighting = true },
	},
})

-- === LAZYGIT ===
vim.cmd("packadd lazygit.nvim")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { buffer = bufnr, desc = "LSP: " .. "LazyGit" })
