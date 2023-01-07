local M = {}

local dap_go = require('dap-go')
local wk = require('which-key')

local function set_keymaps(bufnr)
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
  dap_go.setup()
  _G.set_dap_go_keybindings = function()
    local buf = vim.api.nvim_get_current_buf()
    set_keymaps(buf)
  end
end

return M
