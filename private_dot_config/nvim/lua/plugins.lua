return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'Shougo/denite.nvim'
  use {'gotgenes/fruzzy', branch = 'increase-limit'}
  use 'Shougo/neoyank.vim'

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
  use 'ncm2/float-preview.nvim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'gregsexton/gitv'
  use 'knsh14/vim-github-link'

  -- CI
  use 'martinda/Jenkinsfile-vim-syntax'

  -- Programming
  use 'Shougo/deoplete.nvim'
  use 'Shougo/echodoc.vim'
  use 'dense-analysis/ale'
  use 'maximbaz/lightline-ale'
  use 'scrooloose/nerdcommenter'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'majutsushi/tagbar'
  use 'cohama/lexima.vim'
  use 'Konfekt/FastFold'
  use 'neovim/nvim-lspconfig'
  use 'deoplete-plugins/deoplete-lsp'
  use 'nathunsmitty/nvim-ale-diagnostic'
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' }
  }

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

  -- Velocity
  use 'lepture/vim-velocity'

  -- xonsh
  use 'meatballs/vim-xonsh'
end)
