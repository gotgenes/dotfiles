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
    'mcchrish/zenbones.nvim',
    dependencies = {
      'rktjmp/lush.nvim',
    },
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
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    config = function()
      require('configs.plugins.lualine').setup()
    end,
    event = 'VeryLazy',
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetype_exclude = {
        'NvimTree',
        'Trouble',
        'aerial',
        'alpha',
        'help',
        'lazy',
        'mason',
        'notify',
      },
    },
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('configs.plugins.scrollbar').setup()
    end,
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Telescope',
    keys = {
      {
        '<leader>tb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'search buffers',
      },
      {
        '<leader>tf',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'search files',
      },
      {
        '<leader>tG',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'grep word under cursor',
      },
      {
        '<leader>th',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'search help',
      },
      {
        '<leader>tr',
        function()
          require('telescope.builtin').resume()
        end,
        desc = 'resume last search',
      },
      {
        '<leader>tga',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'grep search all',
      },
      {
        '<leader>tgp',
        function()
          require('telescope.builtin').live_grep({
            glob_pattern = {
              '!*test*',
            },
          })
        end,
        desc = 'grep search production (exclude test files)',
      },
      {
        '<leader>tgt',
        function()
          require('telescope.builtin').live_grep({ glob_pattern = { '*test*' } })
        end,
        'search tests',
      },
      {
        '<leader>th',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'search help',
      },
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
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icon
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
    event = 'VeryLazy',
  },
}
