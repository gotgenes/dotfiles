local M = {}

function M.setup()
  vim.g.better_whitespace_operator = '_s'
  vim.g.better_whitespace_enabled = 1
  vim.g.strip_whitespace_on_save = 1
  vim.g.better_whitespace_filetypes_blacklist = {
    'packer',
    'diff',
    'git',
    'gitcommit',
    'qf',
    'help',
    'markdown',
    'fugitive',
  }
  local colors = require('catppuccin.palettes').get_palette()
  vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = colors.red })
end

return M
