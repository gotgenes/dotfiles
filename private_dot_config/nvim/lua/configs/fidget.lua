local M = {}

local fidget = require('fidget')

function M.setup()
  fidget.setup({
    text = {
      spinner = 'dots',
    },
  })
end

return M
