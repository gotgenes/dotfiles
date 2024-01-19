return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('config.plugins.dap').setup()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('config.plugins.dapui').setup()
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
      require('config.plugins.dap-python').setup()
    end,
    ft = { 'python' },
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('config.plugins.dap-go').setup()
    end,
    ft = { 'go' },
  },
}
