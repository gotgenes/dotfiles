local M = {}

local catppuccin = require('catppuccin')

function M.setup()
  catppuccin.setup({
    flavour = 'mocha',
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
      aerial = true,
      cmp = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      fidget = true,
      gitsigns = true,
      illuminate = true,
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
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  })

  vim.cmd.colorscheme('catppuccin')
end

return M
