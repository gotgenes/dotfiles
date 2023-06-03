return {
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
}
