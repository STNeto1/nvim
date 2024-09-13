return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "supermaven" },
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    -- ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false
                    })
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
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
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),

                suggest_lsp_servers = false,
                sign_icons = {
                    error = "✘",
                    warn = "▲",
                    hint = "⚑",
                    info = "»",
                },
            })

            -- inlayhints
            local ih = require("lsp-inlayhints")
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
                            show = true,
                            prefix = "",
                            separator = ", ",
                            remove_colon_start = false,
                            remove_colon_end = false,
                        },
                        only_current_line = false,
                        labels_separator = "  ",
                        max_len_align = false,
                        max_len_align_padding = 1,
                        highlight = "LspInlayHint",
                        priority = 0,
                    },
                    enabled_at_startup = true,
                    debug_mode = false,
                },
            })

            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        do
                            if server_name == "tsserver" then
                                lspconfig[server_name].setup({
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
                            elseif server_name == "gopls" then
                                lspconfig[server_name].setup({
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
                            elseif server_name == "tailwindcss" then
                                lspconfig[server_name].setup({
                                    capabilities = capabilities,
                                    filetypes = { "*" },
                                })
                            elseif server_name == "biome" then
                                lspconfig[server_name].setup({
                                    capabilities = capabilities,
                                    cmd = { "biome", "lsp-proxy" },
                                    filetypes = {
                                        "javascript",
                                        "javascriptreact",
                                        "json",
                                        "jsonc",
                                        "typescript",
                                        "typescript.tsx",
                                        "typescriptreact",
                                        "astro",
                                        "svelte",
                                        "vue",
                                    },
                                    root_pattern = lspconfig.util.root_pattern("biome.json", "biome.jsonc"),
                                })
                            else
                                lspconfig[server_name].setup({})
                            end
                        end
                    end,
                },
            })
        end,
    },
}
