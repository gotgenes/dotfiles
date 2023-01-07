local M = {}

local nvim_lsp = require('lspconfig')
local lsp_config = require('configs.plugins.lsp')
local ts_utils = require('nvim-lsp-ts-utils')

function M.setup()
  nvim_lsp.tsserver.setup({
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    init_options = ts_utils.init_options,
    capabilities = lsp_config.capabilities,
    --
    on_attach = function(client, bufnr)
      ts_utils.setup({
        always_organize_imports = false,
        update_imports_on_move = true,
      })
      ts_utils.setup_client(client)
      lsp_config.on_attach(client, bufnr)
    end,
  })
end

return M
