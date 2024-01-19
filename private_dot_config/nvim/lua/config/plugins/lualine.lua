local M = {}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local disabled_filetypes = {
  'alpha',
  'dap-repl',
  'dapui_breakpoints',
  'dapui_console',
  'dapui_scopes',
  'dapui_stacks',
  'dapui_watches',
}

function M.setup()
  local lualine = require('lualine')
  lualine.setup({
    options = {
      theme = 'auto',
      disabled_filetypes = {
        statusline = disabled_filetypes,
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'filename', path = 1 },
        { 'b:gitsigns_head', icon = '' },
        {
          'diff',
          source = diff_source,
        },
      },
      lualine_c = {},
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = '󰅚 ', warn = '󰀪 ', hint = '󰌶 ', info = ' ' },
        },
      },
      lualine_y = { 'filetype' },
      lualine_z = {
        { '[%l/%L] :%c', type = 'stl' },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      'aerial',
      'fugitive',
      'lazy',
      'mundo',
      'nvim-dap-ui',
      'nvim-tree',
      'trouble',
    },
  })
end

return M
