local M = {}

function M.setup()
  local colorizer = require('colorizer')
  colorizer.setup({
    filetypes = {
      '*',
      '!lazy',
      '!mason',
    },
    user_default_options = {
      names = false,
    },
  })
end

return M
