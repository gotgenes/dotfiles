local M = {}

local diffview = require('diffview')

function M.setup()
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
