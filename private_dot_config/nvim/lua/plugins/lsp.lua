return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = false,
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
    'creativenull/efmls-configs-nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    event = 'BufRead',
    opts = function()
      return {
        python = {
          formatter = {
            require('efmls-configs.formatters.black'),
            {
              formatCommand = 'isort --quiet --stdout --profile black -',
              formatStdin = true,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local lsp_configs = require('configs.plugins.lsp')
      local efmls_configs = require('efmls-configs')

      efmls_configs.init({
        default_config = true,
        on_attach = lsp_configs.on_attach,
        -- Enable formatting provided by efm langserver
        init_options = {
          documentFormatting = true,
        },
      })
      efmls_configs.setup(opts)
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
    keys = {
      {
        '<leader>o',
        function()
          require('aerial').toggle()
        end,
        desc = 'Aerial toggle',
      },
      {
        ']a',
        function()
          require('aerial').next()
        end,
        desc = 'Aerial next',
      },
      {
        '[a',
        function()
          require('aerial').prev()
        end,
        desc = 'Aerial previous',
      },
      {
        ']A',
        function()
          require('aerial').next_up()
        end,
        desc = 'Aerial next up',
      },
      {
        '[A',
        function()
          require('aerial').prev_up()
        end,
        desc = 'Aerial previous up',
      },
    },
    cmd = { 'AerialToggle', 'AerialNext', 'AerialPrev', 'AerialNextUp', 'AerialPrevUp' },
    opts = {
      layout = {
        min_width = 20,
        placement = 'edge',
      },
      attach_mode = 'global',
      keymaps = {
        ['<leader>o'] = 'actions.close',
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'BufRead',
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
    ft = { 'lua' },
    config = function()
      require('configs.plugins.neodev').setup()
    end,
  },
  {
    'j-hui/fidget.nvim',
    lazy = true,
    init = function()
      require('helpers').on_lsp_attach(function()
        require('fidget')
      end)
    end,
    config = function()
      require('configs.plugins.fidget').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = {
      'Trouble',
      'TroubleClose',
      'TroubleRefresh',
      'TroubleToggle',
    },
    keys = {
      { '<leader>xx', '<Cmd>Trouble<CR>', desc = 'open or jump to Trouble' },
      { '<leader>xc', '<Cmd>TroubleClose<CR>', desc = 'close Trouble' },
      { '<leader>xw', '<Cmd>Trouble workspace_diagnostics<CR>', desc = 'workspace diagnostics' },
      { '<leader>xd', '<Cmd>Trouble document_diagnostics<CR>', desc = 'document diagnostics' },
      { '<leader>xl', '<Cmd>Trouble loclist<CR>', desc = 'location list' },
      { '<leader>xq', '<Cmd>Trouble quickfix<CR>', desc = 'quickfix' },
      { '<leader>xr', '<Cmd>Trouble lsp_references<CR>', desc = 'LSP references' },
    },
    opts = {},
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
