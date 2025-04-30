return {
  {
    'gpanders/nvim-parinfer',
    enabled = false,
    config = function()
      -- Não sei oq faz mas tamo ai
      vim.g.parinfer_filetypes = {
        'dune',
        'scheme',
        'query',
        'racket',
      }
    end,
  },
}
