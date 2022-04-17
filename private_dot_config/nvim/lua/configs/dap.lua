local M = {}

local wk = require('which-key')

local function set_keymaps()
  wk.register({
    d = {
      name = 'debugger',
      b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", 'Set Breakpoint' },
      B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
      c = { "<cmd>lua require('dap').continue()<CR>", 'Start/Continue' },
      s = { "<cmd>lua require('dap').step_into()<CR>", 'Step Into' },
      n = { "<cmd>lua require('dap').step_over()<CR>", 'Step Over' },
      o = { "<cmd>lua require('dap').step_out()<CR>", 'Step Out' },
      u = { "<cmd>lua require('dap').up()<CR>", 'Up' },
      d = { "<cmd>lua require('dap').down()<CR>", 'Down' },
      q = { "<cmd>lua require('dap').terminate()<CR>", 'Terminate' },
    },
  }, {
    prefix = '<leader>',
  })
end

function M.setup()
  set_keymaps()
end

return M
