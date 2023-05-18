local M = {}

function M.setup()
  local copilot = require('copilot')
  copilot.setup({
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-y>',
        next = '<C-)>',
        prev = '<C-(>',
        dismiss = '<C-e>',
      },
    },
  })
end

return M
