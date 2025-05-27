return {
  'mason-org/mason.nvim',
  version = '*',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup {
      ui = {
        icons = {
          -- package_installed = '✓',
          -- package_pending = '➜',
          -- package_uninstalled = '✗',
        },
        border = 'none',
      },
    }

    require('mason-tool-installer').setup {
      integrations = {
        ['mason-lspconfig'] = true,
      },
    }

    require('mason-lspconfig').setup {
      automatic_enable = {
        exclude = {},
      },
    }
  end,
}
