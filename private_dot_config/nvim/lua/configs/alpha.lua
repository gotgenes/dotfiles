local M = {}

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local theta = require('alpha.themes.theta')

local buttons = {
  type = 'group',
  val = {
    { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
    { type = 'padding', val = 1 },
    dashboard.button('e', '  New file', '<Cmd>ene<CR>'),
    dashboard.button('f', '  Find file', '<Cmd>Telescope find_files<CR>'),
    dashboard.button('g', '  Live grep', '<Cmd>Telescope live_grep<CR>'),
    dashboard.button('u', '  Update plugins', '<Cmd>PackerSync<CR>'),
    dashboard.button('q', '  Quit', '<Cmd>qa<CR>'),
  },
  position = 'center',
}

local config = vim.deepcopy(theta.config)

config.layout[#config.layout] = buttons

function M.setup()
  alpha.setup(config)
end

return M
