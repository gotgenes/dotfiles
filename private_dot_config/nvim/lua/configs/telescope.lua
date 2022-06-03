local M = {}

local telescope = require('telescope')
local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    t = {
      name = 'Telescope',
      b = { '<cmd>Telescope buffers<CR>', 'search buffers' },
      f = { '<cmd>Telescope find_files<CR>', 'search files' },
      g = { '<cmd>Telescope live_grep<CR>', 'grep' },
      G = { '<cmd>Telescope grep_string<CR>', 'grep word under cursor' },
      h = { '<cmd>Telescope help_tags<CR>', 'search help' },
      r = { '<cmd>Telescope resume<CR>', 'resume last search' },
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
          ['<c-f>'] = actions.preview_scrolling_down,
          ['<c-b>'] = actions.preview_scrolling_up,
          ['<c-u>'] = false,
          ['<c-d>'] = false,
        },
        n = {
          ['q'] = actions.close,
          ['<c-t>'] = trouble.open_with_trouble,
          ['<c-f>'] = actions.preview_scrolling_down,
          ['<c-b>'] = actions.preview_scrolling_up,
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
      lsp_code_actions = {
        theme = 'cursor',
      },
    },
  })
  set_keymaps()
end

return M
