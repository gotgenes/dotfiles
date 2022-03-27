local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local wk = require('which-key')

require('telescope').setup({
  defaults = {
    path_display = { 'smart' },
    mappings = {
      i = {
        ['<c-t>'] = trouble.open_with_trouble,
      },
      n = {
        ['q'] = actions.close,
        ['<c-t>'] = trouble.open_with_trouble,
      },
    },
  },
  pickers = {
    buffers = {
      initial_mode = 'normal',
      sort_lastused = true,
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

-- General keymaps
wk.register({
  t = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers<CR>', 'search buffers' },
    f = { '<cmd>Telescope find_files<CR>', 'search files' },
    g = { '<cmd>Telescope live_grep<CR>', 'grep' },
    h = { '<cmd>Telescope help_tags<CR>', 'search help' },
    r = { '<cmd>Telescope resume<CR>', 'resume last search' },
  },
}, {
  prefix = '<leader>',
})
