local M = {}

local nvim_window = require('nvim-window')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    w = { nvim_window.pick, 'Pick a window' },
  }, { prefix = '<leader>' })
end

function M.setup()
  nvim_window.setup({})
  set_keymaps()
end

return M
