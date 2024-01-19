local M = {}

function M.setup()
  local better_escape = require('better_escape')
  better_escape.setup({
    mapping = { 'jk', 'jj', 'kj' },
    keys = function()
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<Esc>l' or '<Esc>'
    end,
  })
end

return M
