return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   local disable_filetypes = { c = true, cpp = true }
    --   local lsp_format_opt
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     lsp_format_opt = 'never'
    --   else
    --     lsp_format_opt = 'fallback'
    --   end
    --   return {
    --     timeout_ms = 500,
    --     lsp_format = lsp_format_opt,
    --   }
    -- end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      go = { 'goimports' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      svelte = { 'biome' },
      javascript = { 'biome' },
      graphql = { 'biome' },
      graphqls = { 'biome' },
      json = { 'biome' },
      sql = { 'sleek' },
      toml = { 'taplo' },
      yaml = { 'yamlfmt' },
      elixir = { 'mix' },
      heex = { 'mix' },
      latex = { 'latexindent' },
      ocaml = { 'ocamlformat' },
      terraform = { 'terraform_fmt' },
      zig = { 'zigfmt' },
    },
  },
}
