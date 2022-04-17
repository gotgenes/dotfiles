local M = {}

local trouble = require('trouble')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    x = {
      name = 'Trouble',
      x = { '<cmd>TroubleToggle<cr>', 'toggle' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace diagnostics' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'document_diagnostics' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'location list' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
      r = { '<cmd>TroubleToggle lsp_references<cr>', 'LSP references' },
    },
  }, {
    prefix = '<leader>',
  })
end

function M.setup()
  trouble.setup()
  set_keymaps()
end

return M
