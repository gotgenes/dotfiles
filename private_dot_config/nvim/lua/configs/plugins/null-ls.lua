local M = {}

local null_ls = require('null-ls')
local lsp_config = require('configs.plugins.lsp')

function M.setup()
  local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  null_ls.setup({
    sources = {
      diagnostics.codespell,
      diagnostics.flake8,
      formatting.black,
      formatting.isort,
      formatting.stylua,
      diagnostics.eslint_d,
      code_actions.eslint_d,
      formatting.prettierd,
    },
    on_attach = lsp_config.on_attach_no_symbols,
  })
end

return M
