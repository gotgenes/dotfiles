local M = {}

local better_escape = require('better_escape')

function M.setup()
  better_escape.setup({
    mapping = { 'jk', 'jj', 'kj' },
    keys = function()
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<Esc>l' or '<Esc>'
    end,
  })
end

return M
