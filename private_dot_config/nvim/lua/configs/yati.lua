local M = {}

local ts_configs = require('nvim-treesitter.configs')

function M.setup()
  ts_configs.setup({
    yati = { enable = true },
  })
end

return M
