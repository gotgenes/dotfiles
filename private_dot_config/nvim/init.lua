require('configs.settings').setup()

require('configs.autocmds').setup()

local function ensure_lazy_installed()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  if not vim.tbl_contains(vim.opt.rtp:get(), lazypath) then
    vim.opt.rtp:prepend(lazypath)
  end
end

local function configure_lazy_keymapping()
  local ViewConfig = require('lazy.view.config')
  ViewConfig.keys.profile_filter = '<C-p>'
end

vim.g.no_python_maps = 1

ensure_lazy_installed()
configure_lazy_keymapping()
require('lazy').setup('plugins')

require('configs.keymaps').setup()

require('configs.plugins.diagnostic').setup()
