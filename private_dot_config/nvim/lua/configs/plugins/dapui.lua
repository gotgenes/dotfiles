local M = {}

local dap = require('dap')
local dapui = require('dapui')

local function set_hlgroups()
  local sign = vim.fn.sign_define

  sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
  sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
end

function M.setup()
  dapui.setup({
    layouts = {
      elements = {
        { id = 'watches', size = 0.20 },
        { id = 'breakpoints', size = 0.20 },
        { id = 'stacks', size = 0.25 },
        { id = 'scopes', size = 0.35 },
      },
      size = 50,
      position = 'right',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
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

  set_hlgroups()
end

return M
