local M = {}

function M.setup()
  require('indent_blankline').setup({
    buftype_exclude = { 'help', 'packer' },
    filetype_exclude = { 'alpha', 'mason' },
  })
end

return M
