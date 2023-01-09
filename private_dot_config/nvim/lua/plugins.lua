require('packer').init({
  max_jobs = 60,
})
return require('packer').startup({
  function(use)
    -- Core
    use('wbthomason/packer.nvim')
    use({
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end,
    })

    -- Colors and Themes
    use({
      'catppuccin/nvim',
      as = 'catppuccin',
      config = function()
        require('configs.plugins.catppuccin').setup()
      end,
    })
    use({
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('configs.plugins.colorizer').setup()
      end,
    })

    -- Completion
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
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
    })
    use({
      'L3MON4D3/LuaSnip',
      config = function()
        require('configs.plugins.luasnip').setup()
      end,
    })

    -- Statusline and Visual Components
    use({
      'goolord/alpha-nvim',
      config = function()
        require('configs.plugins.alpha').setup()
      end,
    })
    use({
      'rcarriga/nvim-notify',
      config = function()
        vim.notify = require('notify')
      end,
    })
    use({
      'nvim-lualine/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
        'SmiteshP/nvim-navic',
      },
      config = function()
        require('configs.plugins.lualine').setup()
      end,
    })
    use({
      'SmiteshP/nvim-navic',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('nvim-navic').setup()
      end,
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup({
          buftype_exclude = { 'help', 'packer' },
          filetype_exclude = { 'alpha' },
        })
      end,
    })
    use({
      'petertriho/nvim-scrollbar',
      requires = {
        'kevinhwang91/nvim-hlslens',
      },
      config = function()
        require('configs.plugins.scrollbar').setup()
      end,
    })
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('configs.plugins.telescope').setup()
      end,
    })
    use({
      'stevearc/dressing.nvim',
      requires = {
        'nvim-telescope/telescope.nvim',
      },
    })
    use({
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function()
        require('nvim-tree').setup({
          view = {
            width = 40,
          },
        })
      end,
    })
    use('simnalamburt/vim-mundo')
    use({
      'edluffy/specs.nvim',
      config = function()
        require('configs.plugins.specs').setup()
      end,
    })
    use({
      'https://gitlab.com/yorickpeterse/nvim-window',
      config = function()
        require('configs.plugins.nvim-window').setup()
      end,
    })
    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end,
    })

    -- Productivity and Quality of Life
    use({
      'echasnovski/mini.nvim',
      config = function()
        require('mini.surround').setup()
      end,
    })
    use({
      'machakann/vim-sandwich',
      setup = function()
        vim.g.operator_sandwich_no_default_key_mappings = 1
      end,
      config = function()
        require('configs.plugins.vim-sandwich').setup()
      end,
    })
    use({
      'ntpeters/vim-better-whitespace',
      config = function()
        require('configs.plugins.vim-better-whitespace').setup()
      end,
    })
    use('schickling/vim-bufonly')
    use('AndrewRadev/inline_edit.vim')
    use({
      'ggandor/leap.nvim',
      config = function()
        require('leap').add_default_mappings()
      end,
    })
    use({
      'max397574/better-escape.nvim',
      config = function()
        require('configs.plugins.better-escape').setup()
      end,
    })
    use('AndrewRadev/splitjoin.vim')
    use('wsdjeg/vim-fetch')
    use({
      'vladdoster/remember.nvim',
      config = function()
        require('remember').setup({})
      end,
    })
    use({
      'olimorris/persisted.nvim',
      config = function()
        require('persisted').setup()
      end,
    })
    use('gpanders/editorconfig.nvim')
    use({
      'klen/nvim-config-local',
      config = function()
        require('config-local').setup()
      end,
    })

    -- Programming
    use({
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('configs.plugins.nvim-treesitter').setup()
      end,
      run = ':TSUpdate',
    })
    use({
      'nvim-treesitter/playground',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      run = ':TSInstall query',
    })
    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('configs.plugins.nvim-treesitter-textobjects').setup()
      end,
    })
    use({
      'ziontee113/syntax-tree-surfer',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('configs.plugins.syntax-tree-surfer').setup()
      end,
    })
    use({
      'ThePrimeagen/refactoring.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('configs.plugins.refactoring').setup()
      end,
    })
    use({
      'yioneko/nvim-yati',
      requires = {
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
    })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    })
    use({
      'windwp/nvim-autopairs',
      requires = {
        'hrsh7th/nvim-cmp',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('configs.plugins.nvim-autopairs').setup()
      end,
    })
    use({
      'RRethy/nvim-treesitter-endwise',
      config = function()
        require('nvim-treesitter.configs').setup({
          endwise = {
            enable = true,
          },
        })
      end,
    })
    use({
      'windwp/nvim-ts-autotag',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('nvim-ts-autotag').setup()
      end,
    })
    use('andymass/vim-matchup')
    use({
      'RRethy/vim-illuminate',
      config = function()
        require('configs.plugins.illuminate').setup()
      end,
    })
    use({
      'AndrewRadev/linediff.vim',
      cmd = { 'Linediff', 'LinediffReset' },
    })
    use({
      'sindrets/diffview.nvim',
      config = function()
        require('configs.plugins.diffview')
      end,
    })

    -- LSP
    use({
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('mason-lspconfig').setup({
          automatic_installation = true,
        })
        require('configs.plugins.lsp').setup()
      end,
      requires = {
        'neovim/nvim-lspconfig',
      },
    })
    use({
      'lukas-reineke/lsp-format.nvim',
      config = function()
        require('configs.plugins.lsp-format')
      end,
    })
    use({
      'jose-elias-alvarez/null-ls.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
      },
      config = function()
        require('configs.plugins.null-ls').setup()
      end,
    })
    use({
      'weilbith/nvim-code-action-menu',
      requires = {
        'neovim/nvim-lspconfig',
      },
      cmd = 'CodeActionMenu',
    })
    use({
      'stevearc/aerial.nvim',
      config = function()
        require('configs.plugins.aerial').setup()
      end,
    })
    use({
      'kevinhwang91/nvim-ufo',
      requires = {
        'kevinhwang91/promise-async',
      },
      config = function()
        require('configs.plugins.ufo').setup()
      end,
    })
    use({
      'folke/neodev.nvim',
      requires = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig',
      },
      config = function()
        require('configs.plugins.neodev').setup()
      end,
    })
    use({
      'j-hui/fidget.nvim',
      config = function()
        require('configs.plugins.fidget').setup()
      end,
    })
    use({
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('configs.plugins.trouble').setup()
      end,
    })

    -- DAP
    use({
      'mfussenegger/nvim-dap',
      config = function()
        require('configs.plugins.dap').setup()
      end,
    })
    use({
      'rcarriga/nvim-dap-ui',
      requires = 'mfussenegger/nvim-dap',
      config = function()
        require('configs.plugins.dapui').setup()
      end,
    })
    use({
      'Pocco81/DAPInstall.nvim',
      requires = 'mfussenegger/nvim-dap',
      config = function()
        require('dap-install').setup()
      end,
      cmd = {
        'DIInstall',
        'DIUninstall',
        'DIList',
      },
    })
    use({
      'mfussenegger/nvim-dap-python',
      requires = 'mfussenegger/nvim-dap',
      config = function()
        require('configs.plugins.dap-python').setup()
      end,
      ft = { 'python' },
    })
    use({
      'leoluz/nvim-dap-go',
      requires = 'mfussenegger/nvim-dap',
      config = function()
        require('configs.plugins.dap-go').setup()
      end,
      ft = { 'go' },
    })

    -- Git
    use('tpope/vim-fugitive')
    use('knsh14/vim-github-link')
    use({
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('configs.plugins.gitsigns').setup()
      end,
    })

    -- bats
    use('aliou/bats.vim')

    -- Go
    use({
      'ray-x/go.nvim',
      config = function()
        require('configs.plugins.go').setup()
      end,
      ft = { 'go', 'godoc', 'gomod', 'gotmplhtml', 'gotexttmpl' },
      requires = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig',
      },
    })
    use('gotgenes/golang-template.vim')

    -- Jenkinsfile
    use('martinda/Jenkinsfile-vim-syntax')

    -- LaTeX
    use('lervag/vimtex')

    -- Markdown
    use('godlygeek/tabular')
    use({
      'iamcco/markdown-preview.nvim',
      ft = { 'markdown', 'pandoc.markdown', 'rmd' },
      run = 'cd app & yarn install',
    })

    -- Python
    use('jeetsukumaran/vim-python-indent-black')

    -- Terraform
    use('hashivim/vim-terraform')

    -- Thrift
    use('solarnz/thrift.vim')

    -- TOML
    use('cespare/vim-toml')

    -- TypeScript
    use('leafgarland/typescript-vim')
    use('peitalin/vim-jsx-typescript')
    use({
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = {
        'neovim/nvim-lspconfig',
        'jose-elias-alvarez/null-ls.nvim',
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('configs.plugins.nvim-lsp-ts-utils').setup()
      end,
    })

    -- Velocity
    use('lepture/vim-velocity')

    -- xonsh
    use('meatballs/vim-xonsh')
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
