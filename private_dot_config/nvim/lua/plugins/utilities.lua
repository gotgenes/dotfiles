return {
  {
    'machakann/vim-sandwich',
    init = function()
      vim.g.operator_sandwich_no_default_key_mappings = 1
    end,
    config = function()
      require('config.plugins.vim-sandwich').setup()
    end,
  },
  {
    'ntpeters/vim-better-whitespace',
    init = function()
      require('config.plugins.vim-better-whitespace').setup()
    end,
  },
  { 'schickling/vim-bufonly' },
  { 'AndrewRadev/inline_edit.vim' },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('config.plugins.better-escape').setup()
    end,
  },
  { 'AndrewRadev/splitjoin.vim' },
  { 'wsdjeg/vim-fetch' },
  {
    'vladdoster/remember.nvim',
    config = function()
      require('remember').setup({})
    end,
  },
  {
    'olimorris/persisted.nvim',
    config = function()
      require('persisted').setup()
    end,
  },
  {
    'axkirillov/hbac.nvim',
    dependencies = {
      -- these are optional, add them, if you want the telescope module
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'klen/nvim-config-local',
    opts = {},
    main = 'config-local',
  },
  {
    'gpanders/editorconfig.nvim',
  },
  {
    'shortcuts/no-neck-pain.nvim',
    cmd = {
      'NoNeckPain',
      'NoNeckPainResize',
      'NoNeckPainWidthUp',
      'NoNeckPainWidthDown',
      'NoNeckPainScratchPad',
    },
    opts = {
      width = 130,
      buffers = {
        colors = {
          background = require('catppuccin.palettes').get_palette().crust,
        },
      },
    },
  },
}
