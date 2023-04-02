local M = {}

function M.set_keymaps(bufnr)
  local wk = require('which-key')
  wk.register({
    d = {
      t = {
        name = 'test',
        f = { "<cmd>lua require('dap-go').debug_test()<CR>", 'Test Function/Method' },
      },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
end

function M.setup()
  require('dap-go').setup()
end

return M
