return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'Shougo/denite.nvim'
  use {'gotgenes/fruzzy', branch = 'increase-limit'}
  use 'Shougo/neoyank.vim'

  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
        },
      }
    end
  }
  use 'schickling/vim-bufonly'
  use 'Shougo/defx.nvim'
  use 'kristijanhusak/defx-icons'
  use 'kristijanhusak/defx-git'
  use 'ntpeters/vim-better-whitespace'
  use 'dbakker/vim-projectroot'
  use 'vim-scripts/utl.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'simnalamburt/vim-mundo'
  use 'itchyny/lightline.vim'
  use 'chriskempson/base16-vim'
  use 'mike-hearn/base16-vim-lightline'
  use 'AndrewRadev/splitjoin.vim'
  use 'embear/vim-localvimrc'
  use 'norcalli/nvim-colorizer.lua'

  -- Git
  use 'tpope/vim-fugitive'
  use 'gregsexton/gitv'
  use 'knsh14/vim-github-link'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- CI
  use 'martinda/Jenkinsfile-vim-syntax'

  -- Programming
  use 'b3nj5m1n/kommentary'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'majutsushi/tagbar'
  use 'cohama/lexima.vim'
  use 'Konfekt/FastFold'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    }
  }
  use 'neovim/nvim-lspconfig'
  use 'josa42/nvim-lightline-lsp'
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }
  use 'folke/lsp-colors.nvim'

  -- Go
  use 'fatih/vim-go'
  use 'gotgenes/golang-template.vim'

  -- HTML
  use 'tmhedberg/matchit'
  use 'othree/html5.vim'
  use 'alvan/vim-closetag'

  -- CSS / SASS
  use 'hail2u/vim-css3-syntax'
  use 'cakebaker/scss-syntax.vim'

  -- GraphQL
  use 'jparise/vim-graphql'

  -- JavaScript
  use 'pangloss/vim-javascript'
  use 'maxmellon/vim-jsx-pretty'

  -- LaTeX
  use 'lervag/vimtex'

  -- Markdown
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'
  use {
    'iamcco/markdown-preview.nvim',
    ft = {'markdown', 'pandoc.markdown', 'rmd'},
    run = 'cd app & yarn install'
  }

  -- Python
  use 'tmhedberg/SimpylFold'
  use 'hynek/vim-python-pep8-indent'
  use 'vim-python/python-syntax'

  -- Terraform
  use 'hashivim/vim-terraform'

  -- TOML
  use 'cespare/vim-toml'

  -- TypeScript
  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim'
    }
  }

  -- Velocity
  use 'lepture/vim-velocity'

  -- xonsh
  use 'meatballs/vim-xonsh'
end)
