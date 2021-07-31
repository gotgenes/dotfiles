require("telescope").setup {
  pickers = {
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["dd"] = require("telescope.actions").delete_buffer,
        }
      }
    }
  }
}

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local opts = { noremap=true, silent=true }

-- General keymaps
buf_set_keymap('n', '<leader>tb', '<cmd>Telescope buffers<CR>', opts)
buf_set_keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', opts)
buf_set_keymap('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', opts)
buf_set_keymap('n', '<leader>th', '<cmd>Telescope help_tags<CR>', opts)

-- LSP keymaps (see lsp-config for others)
buf_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
buf_set_keymap('n', '<leader>e', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
