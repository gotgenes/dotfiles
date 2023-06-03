return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('configs.plugins.catppuccin').setup()
    end,
    lazy = false,
    priority = 1000,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('configs.plugins.colorizer').setup()
    end,
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('configs.plugins.alpha').setup()
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
      'SmiteshP/nvim-navic',
    },
    config = function()
      require('configs.plugins.lualine').setup()
    end,
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('nvim-navic').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('configs.plugins.indent-blankline').setup()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('configs.plugins.scrollbar').setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('configs.plugins.telescope').setup()
    end,
  },
  {
    'stevearc/dressing.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require('configs.plugins.nvim-tree').setup()
    end,
  },
  {
    'simnalamburt/vim-mundo',
    config = function()
      vim.g.mundo_right = 1
    end,
  },
  {
    'edluffy/specs.nvim',
    config = function()
      require('configs.plugins.specs').setup()
    end,
  },
  {
    'yorickpeterse/nvim-window',
    config = function()
      require('configs.plugins.nvim-window').setup()
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  },
}
