local M = {}

local aerial = require('aerial')
local wk = require('which-key')

local function set_keymaps(bufnr)
  wk.register({
    a = {
      name = 'Aerial',
      t = { '<Cmd>AerialToggle<CR>', 'toggle' },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    [']a'] = { '<Cmd>AerialNext<CR>', 'aerial next' },
    ['[a'] = { '<Cmd>AerialPrev<CR>', 'aerial previous' },
    [']A'] = { '<Cmd>AerialNextUp<CR>', 'aerial next up' },
    ['[A'] = { '<Cmd>AerialPrevUp<CR>', 'aerial previous up' },
  }, {
    buffer = bufnr,
  })
end

function M.setup()
  aerial.setup({
    layout = {
      min_width = 20,
    },
    on_attach = set_keymaps,
  })
  set_keymaps()
end

return M
