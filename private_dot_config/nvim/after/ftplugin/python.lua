local buf = vim.api.nvim_get_current_buf()
require('config.plugins.dap-python').set_keymaps(buf)
