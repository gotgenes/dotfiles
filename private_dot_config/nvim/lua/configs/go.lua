local M = {}

local path = require('nvim-lsp-installer.core.path')
local lsp_config = require('configs.lsp')
local go = require('go')

function M.setup()
  local gopls_path = path.concat({ vim.fn.stdpath('data'), 'lsp_servers', 'gopls', 'gopls' })
  go.setup({
    lsp_cfg = {
      capabilities = lsp_config.capabilities,
    },
    lsp_on_attach = lsp_config.on_attach,
    gopls_cmd = { gopls_path },
  })
end

return M
