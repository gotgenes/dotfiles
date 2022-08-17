local M = {}

local lua_dev = require('lua-dev')
local nvim_lsp = require('lspconfig')
local lsp_config = require('configs.lsp')

function M.setup()
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  local luadev = lua_dev.setup({
    lspconfig = {
      capabilities = lsp_config.capabilities,
      on_attach = lsp_config.on_attach,
    },
  })
  nvim_lsp.sumneko_lua.setup(luadev)
end

return M
