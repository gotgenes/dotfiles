local M = {}

local illuminate = require('illuminate')

function M.setup()
  illuminate.configure({
    delay = 1000,
    filetypes_denylist = {
      'Mundo',
      'MundoDiff',
      'TelescopePrompt',
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
