local M = {}

local sts = require('syntax-tree-surfer')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    J = { '<cmd>STSSelectNextSiblingNode<CR>', 'select next sibling' },
    K = { '<cmd>STSSelectPrevSiblingNode<CR>', 'select previous sibling' },
    H = { '<cmd>STSSelectParentNode<CR>', 'select parent node' },
    L = { '<cmd>STSSelectChildNode<CR>', 'select child node' },
  }, { mode = 'x' })
end

function M.setup()
  sts.setup({})
  set_keymaps()
end

return M
