local M = {}

local function set_keymaps()
  local nvim_window = require('nvim-window')
  local wk = require('which-key')
  wk.register({
    w = { nvim_window.pick, 'Pick a window' },
  }, { prefix = '<leader>' })
end

function M.setup()
  local nvim_window = require('nvim-window')
  nvim_window.setup({})
  set_keymaps()
end

return M
