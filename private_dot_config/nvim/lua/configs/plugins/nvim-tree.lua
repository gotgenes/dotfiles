local M = {}

local function set_keymaps()
  vim.keymap.set('n', '<leader>ntt', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  vim.keymap.set('n', '<leader>ntc', '<Cmd>NvimTreeFindFile<CR>', { desc = 'Show current file in NvimTree' })
end

function M.setup()
  require('nvim-tree').setup({
    view = {
      width = 40,
    },
  })
  set_keymaps()
end

return M
