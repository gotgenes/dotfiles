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
	  ["q"] = require("telescope.actions").close,
        }
      }
    }
  }
}

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true }

-- General keymaps
set_keymap('n', '<leader>tb', '<cmd>Telescope buffers<CR>', opts)
set_keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', opts)
set_keymap('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', opts)
set_keymap('n', '<leader>th', '<cmd>Telescope help_tags<CR>', opts)

-- LSP keymaps (see lsp-config for others)
set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', opts)
set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
set_keymap('n', '<leader>e', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
