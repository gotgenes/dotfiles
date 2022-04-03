local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>LspDeclaration<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>LspHover<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>LspSignatureHelp<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>LspTypeDef<CR>', opts)
  buf_set_keymap('n', '<leader>cr', '<cmd>LspRename<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>LspFormatting<CR>', opts)
  -- Provided by Telescope
  buf_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  -- Provided by nvim-code-action-menu
  buf_set_keymap('n', '<leader>ca', '<cmd>CodeActionMenu<CR>', opts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
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

local function on_attach_no_format(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  on_attach(client, bufnr)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local function setup()
  nvim_lsp.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach_no_format,
  })

  nvim_lsp.vimls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  local omnisharp_path = vim.fn.stdpath('data') .. '/omnisharp/OmniSharp'
  nvim_lsp.omnisharp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { omnisharp_path, '--languageserver' },
  })
end

return {
  capabilities = capabilities,
  on_attach = on_attach,
  on_attach_no_format = on_attach_no_format,
  setup = setup,
}
