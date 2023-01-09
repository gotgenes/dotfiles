local M = {}

local illuminate = require('illuminate')

function M.setup()
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
