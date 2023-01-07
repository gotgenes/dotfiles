local M = {}

local fidget = require('fidget')

function M.setup()
  fidget.setup({
    text = {
      spinner = 'dots',
    },
    window = {
      blend = 0,
    },
  })
end

return M
