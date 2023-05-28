local M = {}

function M.setup()
  local lsp_format = require('lsp-format')
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
