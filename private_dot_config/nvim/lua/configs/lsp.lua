local M = {}

local nvim_lsp = require('lspconfig')
local wk = require('which-key')

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function set_commands()
  -- Commands.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.cmd('command! LspDeclaration lua vim.lsp.buf.declaration()')
  vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
  vim.cmd('command! LspFormatting lua vim.lsp.buf.formatting()')
  vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
  vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
  vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
  vim.cmd('command! LspOrganize lua lsp_organize_imports()')
  vim.cmd('command! LspRefs lua vim.lsp.buf.references()')
  vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
  vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
  vim.cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')
  vim.cmd('command! LspWorkspaceList lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
  vim.cmd('command! LspWorkspaceAdd lua vim.lsp.buf.add_workspace_folder()')
  vim.cmd('command! LspWorkspaceRemove lua vim.lsp.buf.remove_workspace_folder()')
end

local function set_keymaps(bufnr)
  wk.register({
    g = {
      name = 'LSP goto',
      d = { '<cmd>Telescope lsp_definitions<CR>', 'definitions' },
      D = { '<cmd>LspTypeDef<CR>', 'type definition' },
      L = { '<cmd>LspDeclaration<CR>', 'declaration' },
      i = { '<cmd>Telescope lsp_implementations<CR>', 'implementations' },
      r = { '<cmd>Telescope lsp_references<CR>', 'references' },
    },
    c = {
      name = 'LSP code changes',
      f = { '<cmd>LspFormatting<CR>', 'format' },
      a = { '<cmd>CodeActionMenu<CR>', 'code actions' },
      r = { '<cmd>LspRename<CR>', 'rename variable' },
    },
  }, {
    prefix = '<leader>',
    buffer = bufnr,
  })
  wk.register({
    K = { '<cmd>LspHover<CR>', 'LSP hover' },
    ['<C-S>'] = { '<cmd>LspSignatureHelp<CR>', 'LSP signature help' },
  }, {
    buffer = bufnr,
  })
  wk.register({
    ['<C-S>'] = { '<cmd>LspSignatureHelp<CR>', 'LSP signature help' },
  }, {
    mode = 'i',
    buffer = bufnr,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end
  if vim.b.lsp_buffer_set_up then
    return
  end

  vim.b.lsp_buffer_set_up = 1

  --Enable completion triggered by <c-x><c-o>
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  set_commands()
  set_keymaps(bufnr)
  require('illuminate').on_attach(client)
end

function M.on_attach_no_format(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  M.on_attach(client, bufnr)
end

function M.setup()
  nvim_lsp.pyright.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach_no_format,
  })

  nvim_lsp.vimls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  local omnisharp_path = vim.fn.stdpath('data') .. '/omnisharp/OmniSharp'
  nvim_lsp.omnisharp.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    cmd = { omnisharp_path, '--languageserver' },
  })
end

return M
