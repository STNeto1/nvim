return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
        'saghen/blink.cmp',
      },
      { 'Bilal2453/luvit-meta', lazy = true },

      {
        'j-hui/fidget.nvim',
        tag = 'v1.0.0',
        opts = {},
        enabled = false,
      },
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', enabled = false },

      -- Schema information
      'b0o/SchemaStore.nvim',
      -- { dir = "~/plugins/ocaml.nvim" },
    },
    config = function()
      local lspconfig = require 'lspconfig'

      local servers = {
        bashls = true,
        ruff = { settings = {} },
        basedpyright = { settings = {} },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
            },
          },
        },
        rust_analyzer = true,
        templ = true,
        taplo = true,

        biome = true,

        tailwindcss = {},

        ts_ls = {
          root_dir = require('lspconfig').util.root_pattern 'package.json',
          single_file = false,
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        -- denols = true,
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              -- schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        ocamllsp = {
          manual_install = true,
          cmd = { 'dune', 'tools', 'exec', 'ocamllsp' },
          -- cmd = { "dune", "exec", "ocamllsp" },
          settings = {
            codelens = { enable = true },
            inlayHints = { enable = true },
            syntaxDocumentation = { enable = true },
          },

          server_capabilities = { semanticTokensProvider = false },
        },
      }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities),
        }, config)

        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')

          local settings = servers[client.name]
          if type(settings) ~= 'table' then
            settings = {}
          end

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          local builtin = require 'telescope.builtin'
          vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('<F2>', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- local filetype = vim.bo[bufnr].filetype
          -- if disable_semantic_tokens[filetype] then
          --   client.server_capabilities.semanticTokensProvider = nil
          -- end

          -- Override server capabilities
          -- if settings.server_capabilities then
          --   for k, v in pairs(settings.server_capabilities) do
          --     if v == vim.NIL then
          --       ---@diagnostic disable-next-line: cast-local-type
          --       v = nil
          --     end
          --
          --     client.server_capabilities[k] = v
          --   end
          -- end
        end,
      })
    end,
  },
}
