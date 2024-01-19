local M = {}

function M.set_keymaps(bufnr)
  local wk = require('which-key')

  wk.register({
    d = {
      t = {
        name = 'test',
        f = { "<cmd>lua require('dap-python').test_method()<CR>", 'Test Function/Method' },
        c = { "<cmd>lua require('dap-python').test_class()<CR>", 'Test Class' },
      },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
end

function M.setup()
  local dap_python = require('dap-python')

  dap_python.setup()
  dap_python.test_runner = 'pytest'
end

return M
