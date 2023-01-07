local M = {}

local trouble = require('trouble')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    x = {
      name = 'Trouble',
      x = { '<cmd>Trouble<cr>', 'open / jump to' },
      c = { '<cmd>TroubleClose<cr>', 'close' },
      w = { '<cmd>Trouble workspace_diagnostics<cr>', 'workspace diagnostics' },
      d = { '<cmd>Trouble document_diagnostics<cr>', 'document_diagnostics' },
      l = { '<cmd>Trouble loclist<cr>', 'location list' },
      q = { '<cmd>Trouble quickfix<cr>', 'quickfix' },
      r = { '<cmd>Trouble lsp_references<cr>', 'LSP references' },
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
