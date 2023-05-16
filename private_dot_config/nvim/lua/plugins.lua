local M = {}

local spec = {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('configs.plugins.catppuccin').setup()
    end,
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- Colors and Themes
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('configs.plugins.colorizer').setup()
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    config = function()
      require('configs.plugins.nvim-cmp').setup()
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('configs.plugins.luasnip').setup()
    end,
  },

  -- Statusline and Visual Components
  {
    'goolord/alpha-nvim',
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
      require('indent_blankline').setup({
        buftype_exclude = { 'help', 'packer' },
        filetype_exclude = { 'alpha' },
      })
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

  -- Productivity and Quality of Life
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

  -- Programming
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

  -- LSP
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
      require('configs.plugins.lsp').setup()
    end,
  },
  {
    'lukas-reineke/lsp-format.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('configs.plugins.lsp-format').setup()
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('configs.plugins.null-ls').setup()
    end,
  },
  {
    'weilbith/nvim-code-action-menu',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    cmd = 'CodeActionMenu',
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require('configs.plugins.aerial').setup()
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      require('configs.plugins.ufo').setup()
    end,
  },
  {
    'folke/neodev.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig',
    },
    config = function()
      require('configs.plugins.neodev').setup()
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('configs.plugins.fidget').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('configs.plugins.trouble').setup()
    end,
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('configs.plugins.dap').setup()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('configs.plugins.dapui').setup()
    end,
  },
  {
    'Pocco81/DAPInstall.nvim',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('dap-install').setup()
    end,
    cmd = {
      'DIInstall',
      'DIUninstall',
      'DIList',
    },
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('configs.plugins.dap-python').setup()
    end,
    ft = { 'python' },
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('configs.plugins.dap-go').setup()
    end,
    ft = { 'go' },
  },

  -- Git
  { 'tpope/vim-fugitive' },
  { 'knsh14/vim-github-link' },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('configs.plugins.gitsigns').setup()
    end,
  },

  -- bats
  { 'aliou/bats.vim' },

  -- Go
  {
    'ray-x/go.nvim',
    config = function()
      require('configs.plugins.go').setup()
    end,
    ft = { 'go', 'godoc', 'gomod', 'gotmplhtml', 'gotexttmpl' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig',
    },
  },
  { 'gotgenes/golang-template.vim' },

  -- Jenkinsfile
  { 'martinda/Jenkinsfile-vim-syntax' },

  -- LaTeX
  { 'lervag/vimtex' },

  -- Markdown
  { 'godlygeek/tabular' },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    build = 'cd app & yarn install',
  },

  -- Python
  { 'jeetsukumaran/vim-python-indent-black' },

  -- Terraform
  { 'hashivim/vim-terraform' },

  -- Thrift
  { 'solarnz/thrift.vim' },

  -- TOML
  { 'cespare/vim-toml' },

  -- TypeScript
  {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    dependencies = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('configs.plugins.nvim-lsp-ts-utils').setup()
    end,
  },

  -- Velocity
  { 'lepture/vim-velocity' },

  -- xonsh
  { 'meatballs/vim-xonsh' },
}

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

function M.setup()
  vim.g.no_python_maps = 1

  ensure_lazy_installed()
  configure_lazy_keymapping()
  require('lazy').setup(spec)
end

return M
