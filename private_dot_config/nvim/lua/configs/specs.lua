local M = {}

local specs = require('specs')

function M.setup()
  specs.setup({
    min_jump = 10,
    popup = {
      delay_ms = 5,
      inc_ms = 10,
      winhl = 'IncSearch',
    },
    ignore_filetypes = { 'help' },
  })
end

return M
