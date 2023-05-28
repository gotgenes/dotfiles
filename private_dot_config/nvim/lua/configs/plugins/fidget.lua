local M = {}

function M.setup()
  local fidget = require('fidget')
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
