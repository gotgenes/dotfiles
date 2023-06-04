local M = {}

function M.setup()
  require('indent_blankline').setup({
    buftype_exclude = {
      'help',
    },
    filetype_exclude = {
      'NvimTree',
      'Trouble',
      'alpha',
      'lazy',
      'mason',
      'notify',
    },
  })
end

return M
