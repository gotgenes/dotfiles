local null_ls = require('null-ls')
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local lsp_config = require('configs.lsp')

local node_local = { prefer_local = 'node_modules/.bin' }

null_ls.setup({
  sources = {
    diagnostics.codespell,
    diagnostics.flake8,
    formatting.black,
    formatting.stylua,
    diagnostics.eslint_d.with(node_local),
    code_actions.eslint_d.with(node_local),
    null_ls.builtins.formatting.prettierd.with(node_local),
  },
  on_attach = lsp_config.on_attach,
})
