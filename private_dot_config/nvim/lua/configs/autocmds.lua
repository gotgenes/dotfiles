local M = {}

local function create_automcmds()
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.vtl',
    command = 'set ft=velocity',
  })

  -- Help Neovim check if file has changed on disk
  -- https://github.com/neovim/neovim/issues/2127
  local checktime_group = vim.api.nvim_create_augroup('checktime', { clear = true })
  if vim.fn.has('gui_running') == 0 then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'BufEnter', 'FocusLost', 'WinLeave' }, {
      group = checktime_group,
      pattern = '*',
      command = 'checktime',
    })
  end

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
  })
end

function M.setup()
  create_automcmds()
end

return M
