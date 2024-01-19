local buf = vim.api.nvim_get_current_buf()
require('config.plugins.dap-go').set_keymaps(buf)
