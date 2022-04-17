local M = {}

local dap_install = require('dap-install')
local dap_python = require('dap-python')
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

local function set_up_dap_python()
  local dap_install_path = vim.fn.stdpath('data') .. '/dapinstall'
  dap_python.setup(dap_install_path .. '/python/bin/python')
  dap_python.test_runner = 'pytest'
  _G.set_dap_python_keybindings = function()
    local buf = vim.api.nvim_get_current_buf()
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
      buffer = buf,
    })
  end
end

function M.setup()
  dap_install.setup()
  set_keymaps()
  set_up_dap_python()
  _G.set_dap_go_keybindings = function()
    local buf = vim.api.nvim_get_current_buf()
    wk.register({
      d = {
        t = {
          name = 'test',
          f = { "<cmd>lua require('dap-go').debug_test()<CR>", 'Test Function/Method' },
        },
      },
    }, {
      prefix = '<leader>',
      buffer = buf,
    })
  end

  vim.cmd([[
autocmd FileType python lua set_dap_python_keybindings()
autocmd FileType go lua set_dap_go_keybindings()
]])
end

return M
