local M = {}

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local theta = require('alpha.themes.theta')

local buttons = {
  type = 'group',
  val = {
    { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
    { type = 'padding', val = 1 },
    dashboard.button('e', '  New file', '<cmd>ene<CR>'),
    dashboard.button('SPC t f', '  Find file'),
    dashboard.button('SPC t g', '  Live grep'),
    dashboard.button('u', '  Update plugins', '<cmd>PackerSync<CR>'),
    dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
  },
  position = 'center',
}

local config = vim.deepcopy(theta.config)

config.layout[#config.layout] = buttons

function M.setup()
  alpha.setup(config)
end

return M
