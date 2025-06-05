return {
  -- cmd = { 'lua-language-server' },
  --   filetypes = { 'lua' },
  server_capabilities = {
    documentFormattingProvider = false,
  },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
