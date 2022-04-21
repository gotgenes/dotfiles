local M = {}

local null_ls = require('null-ls')
local lsp_config = require('configs.lsp')

local formatted_filetypes = {
  lua = true,
  python = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  css = true,
  scss = true,
  less = true,
  html = true,
  json = true,
  jsonc = true,
  yaml = true,
  markdown = true,
  graphql = true,
  handlebars = true,
}

local function choose_on_attach(client, bufnr)
  local filetype = vim.bo.filetype
  if formatted_filetypes[filetype] ~= nil then
    return lsp_config.on_attach(client, bufnr)
  else
    return lsp_config.on_attach_no_format(client, bufnr)
  end
end

function M.setup()
  local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  null_ls.setup({
    sources = {
      diagnostics.codespell,
      diagnostics.flake8,
      formatting.black,
      formatting.stylua,
      diagnostics.eslint_d,
      code_actions.eslint_d,
      formatting.prettierd,
    },
    on_attach = choose_on_attach,
  })
end

return M
