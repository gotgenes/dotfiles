local M = {}

local colorizer = require('colorizer')

function M.setup()
  colorizer.setup({
    filetypes = {
      '*',
      '!packer',
    },
    user_default_options = {
      names = false,
    },
  })
end

return M
