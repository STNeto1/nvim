return {
  filetypes = { 'go' },
  settings = {
    ['gopls'] = {
      analyses = {
        unreachable = true,
        unusedparams = true,
        unusedvariable = true,
        staticcheck = true,
      },
      codelenses = {
        generate = true,
        run_govulncheck = true,
      },
      staticcheck = true,
      gofumpt = true,
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
}
