return {
  {
    'machakann/vim-sandwich',
    init = function()
      vim.g.operator_sandwich_no_default_key_mappings = 1
    end,
    config = function()
      require('configs.plugins.vim-sandwich').setup()
    end,
  },
  {
    'ntpeters/vim-better-whitespace',
    config = function()
      require('configs.plugins.vim-better-whitespace').setup()
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
      require('configs.plugins.better-escape').setup()
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
    'klen/nvim-config-local',
    config = function()
      require('config-local').setup()
    end,
  },
  { 'shortcuts/no-neck-pain.nvim' },
}
