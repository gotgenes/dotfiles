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
    keys = { { '<leader>a' }, { ']a' }, { '[a' }, { ']A' }, { '[A' } },
    cmd = { 'AerialToggle', 'AerialNext', 'AerialPrev', 'AerialNextUp', 'AerialPrevUp' },
    event = 'BufRead',
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
  {
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
      'numToStr/Comment.nvim',
      'nvim-telescope/telescope.nvim',
    },
    event = 'User NavicInit',
    command = 'Navbuddy',
    keys = {
      {
        '<enter>',
        function()
          require('nvim-navbuddy').open()
        end,
        desc = 'Open navbuddy',
        mode = 'n',
      },
    },
    init = function()
      require('helpers').on_lsp_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navbuddy').attach(client, buffer)
        end
      end)
    end,
    opts = {
      lsp = {
        auto_attach = true,
      },
    },
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'User NavicInit',
    opts = {
      attach_navic = false,
      exclude_filetypes = {
        'NvimTree',
        'Trouble',
        'alpha',
        'dap-repl',
        'dapui_breakpoints',
        'dapui_console',
        'dapui_scopes',
        'dapui_stacks',
        'dapui_watches',
        'lazy',
        'mason',
        'notify',
      },
    },
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require('helpers').on_lsp_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
          vim.api.nvim_exec_autocmds('User', {
            pattern = 'NavicInit',
          })
        end
      end)
    end,
  },
}
