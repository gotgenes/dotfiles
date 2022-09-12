local M = {}

local lua_dev = require('lua-dev')
local nvim_lsp = require('lspconfig')
local lsp_config = require('configs.lsp')

function M.setup()
  lua_dev.setup()
  nvim_lsp.sumneko_lua.setup({
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.on_attach,
  })
end

return M
