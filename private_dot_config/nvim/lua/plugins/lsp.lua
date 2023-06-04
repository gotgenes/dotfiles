return {
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
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('configs.plugins.trouble').setup()
    end,
  },
}
