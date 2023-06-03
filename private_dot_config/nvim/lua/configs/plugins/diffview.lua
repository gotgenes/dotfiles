local M = {}

function M.setup()
  local diffview = require('diffview')
  diffview.setup({
    view = {
      default = {
        layout = 'diff2_vertical',
      },
      merge_tool = {
        layout = 'diff3_vertical',
      },
      file_history = {
        layout = 'diff2_vertical',
      },
    },
    enhanced_diff_hl = true,
    hooks = {
      diff_buf_read = function()
        vim.opt_local.foldlevel = 99
        vim.opt_local.foldenable = false
      end,
      diff_buf_win_enter = function()
        vim.opt_local.foldlevel = 99
        vim.opt_local.foldenable = false
      end,
    },
  })
end

return M
