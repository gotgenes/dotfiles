local M = {}

local symbols_outline = require('symbols-outline')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    o = {
      name = 'Symbols outline',
      t = { '<Cmd>SymbolsOutline<CR>', 'toggle' },
    },
  }, {
    prefix = '<leader>',
  })
end

function M.setup()
  symbols_outline.setup({
    auto_preview = false,
  })
  set_keymaps()
end

return M
