local M = {}

function M.setup()
  local install_root_dir = require('mason.settings').current.install_root_dir
  local path = require('mason-core.path')
  local lsp_config = require('configs.plugins.lsp')
  local go = require('go')

  local gopls_path = path.concat({ install_root_dir, 'bin', 'gopls' })
  go.setup({
    lsp_cfg = {
      capabilities = lsp_config.capabilities,
    },
    lsp_on_attach = lsp_config.on_attach,
    gopls_cmd = { gopls_path },
  })
end

return M
