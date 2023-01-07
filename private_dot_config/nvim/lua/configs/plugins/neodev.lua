local M = {}

local neodev = require('neodev')
local nvim_lsp = require('lspconfig')
local lsp_config = require('configs.plugins.lsp')

function M.setup()
  neodev.setup()
  nvim_lsp.sumneko_lua.setup({
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.on_attach,
  })
end

return M
