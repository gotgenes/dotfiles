local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

require('telescope').setup({
  defaults = {
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

local function set_keymap(...)
  vim.api.nvim_set_keymap(...)
end
local opts = { noremap = true, silent = true }

-- General keymaps
set_keymap('n', '<leader>tb', '<cmd>Telescope buffers<CR>', opts)
set_keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', opts)
set_keymap('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', opts)
set_keymap('n', '<leader>th', '<cmd>Telescope help_tags<CR>', opts)
set_keymap('n', '<leader>tr', '<cmd>Telescope resume<CR>', opts)
