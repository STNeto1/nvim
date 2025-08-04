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
      },
      -- Schema information
      'b0o/SchemaStore.nvim',
      -- { dir = "~/plugins/ocaml.nvim" },
    },
    config = function()
      for _, svr_name in ipairs {
        'gopls',
        'jsonls',
        'luals',
        'tsserver',
        'yamlls',
        'tailwindcss',
        'biome',
        'graphql',
        'ocamllsp',
        'ruff',
      } do
        vim.lsp.enable(svr_name)

        vim.lsp.config(svr_name, {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client:supports_method 'textDocument/completion' then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
          end
          if client:supports_method 'textDocument/inlayHint' then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
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
        end,
      })
    end,
  },
}
