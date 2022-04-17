local M = {}

local dap = require('dap')
local dapui = require('dapui')

function M.setup()
  dapui.setup({
    sidebar = {
      elements = {
        { id = 'watches', size = 0.20 },
        { id = 'breakpoints', size = 0.20 },
        { id = 'stacks', size = 0.25 },
        { id = 'scopes', size = 0.35 },
      },
      size = 50,
      position = 'right',
    },
  })

  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end
end

return M
