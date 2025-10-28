return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
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
        diffview = true,
        grug_far = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
        neotree = true,
        neotest = true,
        noice = true,
        notify = true,
        snacks = true,
        which_key = true,
        window_picker = true,
      },
    },
    lazy = false,
    priority = 1000,
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = true,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        command_palette = false,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    lazy = true,
    init = function()
      vim.g.navic_silence = true
    end,
    opts = function()
      Snacks.util.lsp.on({ method = "textDocument/documentSymbol" }, function(buffer, client)
        require("nvim-navic").attach(client, buffer)
      end)
      return {
        highlight = true,
        depth_limit = 5,
        icons = LazyVim.config.icons.kinds,
        lazy_update_context = true,
      }
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "SmiteshP/nvim-navic",
    },
    opts = function()
      Snacks.util.lsp.on({ method = "textDocument/documentSymbol" }, function(buffer, client)
        require("nvim-navbuddy").attach(client, buffer)
      end)
      return {
        icons = LazyVim.config.icons.kinds,
      }
    end,
    cmd = "Navbuddy",
    keys = {
      {
        "<CR>",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = "open navbuddy",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = require("config.plugins.lualine").opts,
  },
  {
    "folke/snacks.nvim",
    opts = require("config.plugins.snacks").opts,
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    opts = {},
    cmd = {
      "CccPick",
      "CccConvert",
      "CccHighlighterEnable",
      "CccHighlighterDisable",
      "CccHighlighterToggle",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      {
        "kevinhwang91/nvim-hlslens",
        keys = {
          {
            "n",
            function()
              if vim.v.searchforward == 1 then
                vim.cmd.normal({ "nzv", bang = true })
              else
                vim.cmd.normal({ "Nzv", bang = true })
              end
              require("hlslens").start()
            end,
            remap = false,
            desc = "Next search result",
          },
          {
            "N",
            function()
              if vim.v.searchforward == 1 then
                vim.cmd.normal({ "Nzv", bang = true })
              else
                vim.cmd.normal({ "nzv", bang = true })
              end
              require("hlslens").start()
            end,
            remap = false,
            desc = "Next search result",
          },
          {
            "*",
            [[*<Cmd>lua require('hlslens').start()<CR>]],
          },
          {
            "#",
            [[#<Cmd>lua require('hlslens').start()<CR>]],
          },
          {
            "g*",
            [[g*<Cmd>lua require('hlslens').start()<CR>]],
          },
          {
            "g#",
            [[g#<Cmd>lua require('hlslens').start()<CR>]],
          },
        },
      },
    },
    opts = {
      handle = {
        highlight = "ColorColumn",
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        search = true,
      },
    },
    config = function(_, opts)
      require("scrollbar").setup(opts)
    end,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<Esc>",
        function()
          vim.cmd("noh")
          require("scrollbar.handlers.search").nohlsearch()
          local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
          vim.cmd.normal({ key, bang = true })
        end,
        desc = "Escape and clear hlsearch",
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      min_horizontal_distance_smear = 30,
      min_vertical_distance_smear = 12,
      smear_to_cmd = false,
      delay_event_to_smear = 100,
      filetypes_disabled = {
        "NeoTree",
        "Trouble",
        "dap-repl",
        "dapui_breakpoints",
        "dapui_console",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dashboard",
        "help",
        "lazy",
        "lazy",
        "mason",
        "noice",
        "notify",
        "snacks",
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    keys = {
      {
        "<leader>wp",
        function()
          local selected_window = require("window-picker").pick_window()
          if selected_window ~= nil then
            vim.api.nvim_set_current_win(selected_window)
          end
        end,
        desc = "pick",
      },
    },
    opts = function()
      local palette = require("catppuccin.palettes").get_palette()
      return {
        hint = "floating-big-letter",
        selection_chars = "uhetonaspg.c,r",
        picker_config = {
          statusline_winbar_picker = {
            use_winbar = "auto",
          },
        },
        autoselect_one = true,
        include_current = false,
        show_prompt = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "NvimTree", "fidget", "neo-tree", "neo-tree-popup", "notify" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
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
              fg = "#ededed",
              bg = palette.blue,
              bold = true,
            },
          },
        },
      }
    end,
  },
  {
    "nvim-mini/mini.hipatterns",
    opts = require("config.plugins.mini-hipatterns").opts,
  },
}
