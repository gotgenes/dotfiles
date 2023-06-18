return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'macchiato',
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        aerial = true,
        cmp = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        fidget = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        leap = true,
        lsp_trouble = true,
        markdown = true,
        navic = {
          enabled = true,
          custom_bg = 'NONE',
        },
        native_lsp = {
          enabled = true,
        },
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    lazy = false,
    priority = 1000,
  },
  {
    'mcchrish/zenbones.nvim',
    dependencies = {
      'rktjmp/lush.nvim',
    },
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {},
    cmd = {
      'CccPick',
      'CccConvert',
      'CccHighlighterEnable',
      'CccHighlighterDisable',
      'CccHighlighterToggle',
    },
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('configs.plugins.alpha').setup()
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    config = function()
      require('configs.plugins.lualine').setup()
    end,
    event = 'VeryLazy',
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetype_exclude = {
        'NvimTree',
        'Trouble',
        'aerial',
        'alpha',
        'help',
        'lazy',
        'mason',
        'notify',
      },
    },
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('configs.plugins.scrollbar').setup()
    end,
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'danielfalk/smart-open.nvim',
        opts = {},
        config = function()
          require('telescope').load_extension('smart_open')
        end,
        dependencies = {
          'kkharji/sqlite.lua',
          'nvim-telescope/telescope-fzy-native.nvim',
        },
        keys = { {
          '<leader>tf',
          function()
            require('telescope').extensions.smart_open.smart_open()
          end,
          desc = 'search files by frecency',
        } },
      },
    },
    cmd = 'Telescope',
    keys = {
      {
        '<leader>tb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'search buffers',
      },
      {
        '<leader>tF',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'search files',
      },
      {
        '<leader>tG',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'grep word under cursor',
      },
      {
        '<leader>th',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'search help',
      },
      {
        '<leader>tr',
        function()
          require('telescope.builtin').resume()
        end,
        desc = 'resume last search',
      },
      {
        '<leader>tga',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'grep search all',
      },
      {
        '<leader>tgp',
        function()
          require('telescope.builtin').live_grep({
            glob_pattern = {
              '!*test*',
            },
          })
        end,
        desc = 'grep search production (exclude test files)',
      },
      {
        '<leader>tgt',
        function()
          require('telescope.builtin').live_grep({ glob_pattern = { '*test*' } })
        end,
        'search tests',
      },
      {
        '<leader>th',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'search help',
      },
    },
    config = function()
      require('configs.plugins.telescope').setup()
    end,
  },
  {
    'stevearc/dressing.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require('configs.plugins.nvim-tree').setup()
    end,
  },
  {
    'simnalamburt/vim-mundo',
    config = function()
      vim.g.mundo_right = 1
    end,
  },
  {
    'edluffy/specs.nvim',
    config = function()
      require('configs.plugins.specs').setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    keys = {
      {
        '<leader>w',
        function()
          local selected_window = require('window-picker').pick_window()
          if selected_window ~= nil then
            vim.api.nvim_set_current_win(selected_window)
          end
        end,
        desc = 'pick window',
      },
    },
    opts = function()
      local palette = require('catppuccin.palettes').get_palette()
      return {
        hint = 'floating-big-letter',
        selection_chars = 'uhetonaspg.c,r',
        picker_config = {
          statusline_winbar_picker = {
            use_winbar = 'auto',
          },
        },
        autoselect_one = true,
        include_current = false,
        show_prompt = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'NvimTree', 'fidget', 'neo-tree', 'neo-tree-popup', 'notify' },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', 'quickfix' },
          },
        },
        highlights = {
          statusline = {
            focused = {
              fg = palette.text,
              bg = palette.surface1,
              bold = true,
            },
            unfocused = {
              fg = palette.text,
              bg = palette.blue,
              bold = true,
            },
          },
          winbar = {
            focused = {
              fg = palette.text,
              bg = palette.rosewater,
              bold = true,
            },
            unfocused = {
              fg = '#ededed',
              bg = palette.blue,
              bold = true,
            },
          },
        },
      }
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
    event = 'VeryLazy',
  },
}
