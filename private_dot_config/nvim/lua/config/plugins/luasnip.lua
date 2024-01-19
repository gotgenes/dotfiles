local M = {}

local function set_keymaps()
  local wk = require('which-key')
  wk.register({
    ['<C-s>'] = { '<Plug>luasnip-expand-snippet', 'expand snippet (luasnip)' },
    ['<C-j>'] = { '<Plug>luasnip-jump-next', 'jump next position (luasnip)' },
    ['<C-l>'] = { '<Plug>luasnip-jump-prev', 'jump previous position (luasnip)' },
  }, { mode = 'i' })
  wk.register({
    ['<C-s>'] = { '<Plug>luasnip-expand-snippet', 'expand snippet (luasnip)' },
    ['<C-j>'] = { '<Plug>luasnip-jump-next', 'jump next position (luasnip)' },
    ['<C-l>'] = { '<Plug>luasnip-jump-prev', 'jump previous position (luasnip)' },
  }, { mode = 's' })
end

function M.setup()
  local luasnip = require('luasnip')
  luasnip.config.setup({
    history = true,
  })
  set_keymaps()
end

return M
