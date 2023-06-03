return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('configs.plugins.nvim-treesitter').setup()
    end,
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    build = ':TSInstall query',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.plugins.nvim-treesitter-textobjects').setup()
    end,
  },
  {
    'ziontee113/syntax-tree-surfer',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.plugins.syntax-tree-surfer').setup()
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.plugins.refactoring').setup()
    end,
  },
  {
    'yioneko/nvim-yati',
    dependencies = {
      {
        'yioneko/vim-tmindent',
        config = function()
          require('tmindent').setup({})
        end,
      },
    },
    config = function()
      require('configs.plugins.yati').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.plugins.nvim-autopairs').setup()
    end,
  },
  {
    'RRethy/nvim-treesitter-endwise',
    config = function()
      require('nvim-treesitter.configs').setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('configs.plugins.illuminate').setup()
    end,
  },
  {
    'AndrewRadev/linediff.vim',
    cmd = { 'Linediff', 'LinediffReset' },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('configs.plugins.diffview')
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('configs.plugins.copilot').setup()
    end,
  },
}
