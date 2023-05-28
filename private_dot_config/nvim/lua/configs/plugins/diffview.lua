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
  })
end

return M
