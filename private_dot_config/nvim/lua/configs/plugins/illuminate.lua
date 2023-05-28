local M = {}

function M.setup()
  local illuminate = require('illuminate')
  illuminate.configure({
    delay = 2500,
    filetypes_denylist = {
      'Mundo',
      'MundoDiff',
      'TelescopePrompt',
      'alpha',
      'fugitive',
      'git',
      'gitcommit',
      'help',
      'markdown',
      'packer',
      'qf',
    },
  })
end

return M
