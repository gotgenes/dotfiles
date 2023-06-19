local M = {}

function M.setup()
  local neodev = require('neodev')
  local nvim_lsp = require('lspconfig')
  local lsp_config = require('configs.plugins.lsp')
  neodev.setup({})
  nvim_lsp.lua_ls.setup({
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.on_attach,
  })
end

return M
