local M = {}

local lua_dev = require('lua-dev')
local nvim_lsp = require('lspconfig')

function M.setup()
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  local sumneko_lua_root = vim.fn.stdpath('data') .. '/lua-language-server/'
  local luadev = lua_dev.setup({
    lspconfig = {
      cmd = {
        sumneko_lua_root .. 'bin/lua-language-server',
        '-E',
        sumneko_lua_root .. 'main.lua',
      },
      on_attach = require('configs.lsp').on_attach_no_format,
    },
  })
  nvim_lsp.sumneko_lua.setup(luadev)
end

return M
