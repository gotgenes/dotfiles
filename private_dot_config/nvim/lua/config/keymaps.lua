local M = {}

local function set_keymaps()
  local wk = require('which-key')

  wk.register({
    j = { 'gj', 'Down' },
    k = { 'gk', 'Up' },
  })
  wk.register({
    ['/'] = { '<Cmd>nohlsearch<CR>', 'Clear search highlighting' },
    ['<space>'] = { 'za', 'Toggle fold' },
    hc = { '<Cmd>helpclose<CR>', 'Close the help window' },
  }, {
    prefix = '<leader>',
  })
  wk.register({
    ['<F5>'] = { '<C-R>=strftime("%F")<CR>', 'Insert date' },
  })
  wk.register({
    ['<F5>'] = { 'a<C-R>=strftime("%F")<CR><Esc>', 'Insert date' },
  }, {
    mode = 'i',
  })
  wk.register({
    ['<space>'] = { 'zf', 'Create manual fold' },
  }, {
    mode = 'v',
  })
end

function M.setup()
  set_keymaps()
end

return M
