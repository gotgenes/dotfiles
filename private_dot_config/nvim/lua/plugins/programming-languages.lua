return {
  -- bats
  {
    'aliou/bats.vim',
    ft = { 'bats' },
  },

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
  {
    'gotgenes/golang-template.vim',
    ft = { 'gotmplhtml', 'gotexttmpl' },
  },

  -- Jenkinsfile
  {
    'martinda/Jenkinsfile-vim-syntax',
    ft = 'jenkinsfile',
  },

  -- LaTeX
  {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
  },

  -- Markdown
  {
    'godlygeek/tabular',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    build = 'cd app & yarn install',
  },

  -- Python
  {
    'jeetsukumaran/vim-python-indent-black',
    ft = 'python',
  },

  -- TypeScript
  {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    dependencies = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    ft = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
    config = function()
      require('configs.plugins.nvim-lsp-ts-utils').setup()
    end,
  },

  -- Velocity
  {
    'lepture/vim-velocity',
    ft = 'velocity',
  },

  -- xonsh
  {
    'meatballs/vim-xonsh',
    ft = 'xonsh',
  },
}
