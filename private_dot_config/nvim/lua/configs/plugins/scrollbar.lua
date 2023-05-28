local M = {}

local function set_keymaps()
  local wk = require('which-key')
  wk.register({
    ['n'] = { [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], '* search' },
    ['N'] = { [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], '* search' },
    ['*'] = { [[*<Cmd>lua require('hlslens').start()<CR>]], '* search' },
    ['#'] = { [[#<Cmd>lua require('hlslens').start()<CR>]], '# search' },
    ['g*'] = { [[g*<Cmd>lua require('hlslens').start()<CR>]], 'g* search' },
    ['g#'] = { [[g#<Cmd>lua require('hlslens').start()<CR>]], 'g# search' },
  }, {})
end

function M.setup()
  local scrollbar = require('scrollbar')
  local scrollbar_search = require('scrollbar.handlers.search')
  scrollbar.setup({
    handle = {
      highlight = 'ColorColumn',
    },
  })
  scrollbar_search.setup({
    calm_down = true,
  })
  set_keymaps()
end

return M
