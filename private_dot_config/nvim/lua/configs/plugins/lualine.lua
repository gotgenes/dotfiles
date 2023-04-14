local M = {}

local lualine = require('lualine')
local navic = require('nvim-navic')

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

function M.setup()
  lualine.setup({
    options = {
      theme = 'catppuccin',
      disabled_filetypes = {
        statusline = { 'alpha' },
        winbar = { 'alpha' },
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
          symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
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
    winbar = {
      lualine_a = {},
      lualine_b = { 'filename' },
      lualine_c = {
        {
          function()
            return navic.get_location()
          end,
          cond = navic.is_available,
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
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
