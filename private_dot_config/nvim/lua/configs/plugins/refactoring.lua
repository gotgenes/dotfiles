local M = {}

local refactoring = require('refactoring')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    r = {
      name = 'refactoring',
      e = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", 'extract function' },
      f = {
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        'extract function to file',
      },
      v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], 'extract variable' },
      i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], 'inline variable' },
      r = { [[ <Esc><Cmd>lua require('refactoring').select_refactor()<CR> ]], 'select refactoring' },
    },
  }, {
    prefix = '<leader>',
    mode = 'v',
  })
  wk.register({
    r = {
      name = 'refactoring',
      b = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], 'extract block' },
      f = {
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        'extract function to file',
      },
      i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], 'inline variable' },
    },
  }, {
    prefix = '<leader>',
  })
end

function M.setup()
  refactoring.setup({})
  set_keymaps()
end

return M
