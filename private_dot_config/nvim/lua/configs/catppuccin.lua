local M = {}

local catppuccin = require('catppuccin')

function M.setup()
  vim.g.catppuccin_flavour = 'mocha'

  catppuccin.setup({
    compile = { enabled = true },
    styles = {
      comments = { 'italic' },
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      cmp = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      fidget = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      leap = true,
      lsp_trouble = true,
      markdown = true,
      navic = {
        enabled = true,
        custom_bg = 'NONE',
      },
      native_lsp = {
        enabled = true,
      },
      notify = true,
      nvimtree = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  })

  vim.cmd([[colorscheme catppuccin]])
end

return M