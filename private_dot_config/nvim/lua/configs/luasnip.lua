local luasnip = require('luasnip')
luasnip.config.setup({
  history = true,
})

local opts = {}
vim.api.nvim_set_keymap('i', '<C-s>', '<Plug>luasnip-expand-snippet', opts)
vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>luasnip-jump-next', opts)
vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>luasnip-jump-prev', opts)

vim.api.nvim_set_keymap('s', '<C-s>', '<Plug>luasnip-expand-snippet', opts)
vim.api.nvim_set_keymap('s', '<C-j>', '<Plug>luasnip-jump-next', opts)
vim.api.nvim_set_keymap('s', '<C-l>', '<Plug>luasnip-jump-prev', opts)
