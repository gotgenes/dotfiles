local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local trouble = require('trouble.providers.telescope')

  telescope.setup({
    defaults = {
      path_display = { 'truncate' },
      mappings = {
        i = {
          ['<c-t>'] = trouble.open_with_trouble,
          ['<c-f>'] = actions.results_scrolling_down,
          ['<c-b>'] = actions.results_scrolling_up,
          ['<c-u>'] = false,
          ['<c-d>'] = false,
        },
        n = {
          ['q'] = actions.close,
          ['<c-t>'] = trouble.open_with_trouble,
          ['<c-f>'] = actions.results_scrolling_down,
          ['<c-b>'] = actions.results_scrolling_up,
          ['<c-d>'] = actions.preview_scrolling_down,
          ['<c-u>'] = actions.preview_scrolling_up,
        },
      },
    },
    pickers = {
      buffers = {
        initial_mode = 'normal',
        sort_lastused = true,
        sort_mru = true,
        selection_strategy = 'closest',
        theme = 'dropdown',
        previewer = false,
        mappings = {
          i = {
            ['<c-d>'] = actions.delete_buffer,
          },
          n = {
            ['dd'] = actions.delete_buffer,
          },
        },
      },
    },
  })
end

return M
