return {
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
