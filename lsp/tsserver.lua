return {
  filetypes = { 'typescript', 'typescriptreact' },
  settings = {
    ['ts_ls'] = {
      root_dir = require('lspconfig').util.root_pattern 'package.json',
      single_file = false,
      server_capabilities = {
        documentFormattingProvider = false,
      },
    },
  },
}
