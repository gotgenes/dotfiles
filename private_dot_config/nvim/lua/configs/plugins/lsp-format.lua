local M = {}

local lsp_format = require('lsp-format')

function M.setup()
  lsp_format.setup({
    python = {
      sync = true,
    },
    lua = {
      order = { 'lua_ls', 'null-ls' },
    },
  })
end

return M
