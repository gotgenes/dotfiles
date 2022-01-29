local sumneko_lua_root = vim.fn.stdpath('data') .. '/lua-language-server/'
local luadev = require('lua-dev').setup({
  lspconfig = {
    cmd = {
      sumneko_lua_root .. 'bin/lua-language-server',
      '-E',
      sumneko_lua_root .. 'main.lua',
    },
    on_attach = require('configs.lsp').on_attach_no_format,
  },
})
require('lspconfig')['sumneko_lua'].setup(luadev)
