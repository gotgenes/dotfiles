local M = {}

local ts_configs = require('nvim-treesitter.configs')
local wk = require('which-key')

local function set_keymaps()
  local mappings = {
    [']m'] = { '<cmd>TSTextobjectGotoNextStart @function.outer<CR>', 'Go to next function start' },
    ['[m'] = { '<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>', 'Go to previous function start' },
    [']M'] = { '<cmd>TSTextobjectGotoNextEnd @function.outer<CR>', 'Go to next function end' },
    ['[M'] = { '<cmd>TSTextobjectGotoPreviousEnd @function.outer<CR>', 'Go to previous function end' },
    [']['] = { '<cmd>TSTextobjectGotoNextStart @class.outer<CR>', 'Go to next class start' },
    ['[['] = { '<cmd>TSTextobjectGotoPreviousStart @class.outer<CR>', 'Go to previous class start' },
    [']]'] = { '<cmd>TSTextobjectGotoNextEnd @class.outer<CR>', 'Go to next class end' },
    ['[]'] = { '<cmd>TSTextobjectGotoPreviousEnd @class.outer<CR>', 'Go to next class end' },
  }
  wk.register(mappings, { mode = 'n' })
  wk.register(mappings, { mode = 'v' })
  wk.register(mappings, { mode = 'o' })
end

function M.setup()
  ts_configs.setup({
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
      },
    },
  }) -- ha
  set_keymaps()
end

return M
