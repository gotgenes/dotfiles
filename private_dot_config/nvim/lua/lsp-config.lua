local nvim_lsp = require('lspconfig')

require("nvim-ale-diagnostic")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Commands.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagShow lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspWorkspaceList lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
  vim.cmd("command! LspWorkspaceAdd lua vim.lsp.buf.add_workspace_folder()")
  vim.cmd("command! LspWorkspaceRemove lua vim.lsp.buf.remove_workspace_folder()")

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See telescope-config for other LSP mappings
  buf_set_keymap('n', 'gD', '<Cmd>LspDeclaration<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>LspHover<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>LspSignatureHelp<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>LspTypeDef<CR>', opts)
  buf_set_keymap('n', '<leader>cr', '<cmd>LspRename<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>LspDiagPrev<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>LspDiagNext<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>LspFormatting<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "vimls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp.gopls.setup {
  cmd = { "gopls", "-remote=auto" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
