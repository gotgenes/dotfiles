local M = {}

local wk = require('which-key')

local function set_commands()
  vim.cmd('command! DiagnosticPrev lua vim.diagnostic.goto_prev()')
  vim.cmd('command! DiagnosticNext lua vim.diagnostic.goto_next()')
  vim.cmd('command! DiagnosticLine lua vim.diagnostic.open_float({ source = true })')
end

local function set_keymaps()
  wk.register({
    e = {
      name = 'Diagnostic',
      l = { '<cmd>DiagnosticLine<CR>', 'show for current line' },
      n = { '<cmd>DiagnosticNext<CR>', 'jump to next' },
      p = { '<cmd>DiagnosticPrev<CR>', 'jump to previous' },
    },
  }, {
    prefix = '<leader>',
  })
  wk.register({
    E = { '<cmd>DiagnosticLine<CR>', 'show diagnostic for current line' },
  })
end

local function set_signs()
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

function M.setup()
  set_commands()
  set_keymaps()
  set_signs()
  vim.diagnostic.config({
    virtual_text = false,
  })
end

return M
