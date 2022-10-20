local M = {}

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    t = {
      name = 'Telescope',
      b = { builtin.buffers, 'search buffers' },
      f = { builtin.find_files, 'search files' },
      G = { builtin.grep_string, 'grep word under cursor' },
      h = { builtin.help_tags, 'search help' },
      r = { builtin.resume, 'resume last search' },
      g = {
        name = 'grep',
        a = { builtin.live_grep, 'search all' },
        p = {
          function()
            builtin.live_grep({ glob_pattern = { '!*test*' } })
          end,
          'search production (exclude test files)',
        },
        t = {
          function()
            builtin.live_grep({ glob_pattern = { '*test*' } })
          end,
          'search tests',
        },
      },
    },
  }, {
    prefix = '<leader>',
  })
end

function M.setup()
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
  set_keymaps()
end

return M
