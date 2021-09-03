local null_ls = require('null-ls')
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.config({
  sources = {
    diagnostics.flake8,
    formatting.black,
    formatting.stylua,
  },
})
