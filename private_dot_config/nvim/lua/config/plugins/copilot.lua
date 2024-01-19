local M = {}

function M.setup()
  local copilot = require('copilot')
  copilot.setup({
    suggestion = {
      auto_trigger = true,
    },
  })
end

return M
