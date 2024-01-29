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
          custom_bg = "NONE",
        },
        native_lsp = {
          enabled = true,
        },
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
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
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.center = {

        {
          action = "Telescope smart_open cwd_only=true",
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },
        {
          action = [[lua require("telescope.builtin").oldfiles({ only_cwd = true })]],
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = "Telescope live_grep",
          desc = " Find text",
          icon = " ",
          key = "g",
        },
        {
          action = [[lua require("lazyvim.util").telescope.config_files()()]],
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = "LazyExtras",
          desc = " Lazy Extras",
          icon = " ",
          key = "x",
        },
        {
          action = "Lazy",
          desc = " Lazy",
          icon = "󰒲 ",
          key = "l",
        },
        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
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
      "kevinhwang91/nvim-hlslens",
    },
    config = function()
      require("config.plugins.scrollbar").setup()
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "edluffy/specs.nvim",
    config = function()
      require("config.plugins.specs").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    keys = {
      {
        "<leader>w",
        function()
          local selected_window = require("window-picker").pick_window()
          if selected_window ~= nil then
            vim.api.nvim_set_current_win(selected_window)
          end
        end,
        desc = "pick window",
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
    "shortcuts/no-neck-pain.nvim",
    cmd = {
      "NoNeckPain",
      "NoNeckPainResize",
      "NoNeckPainWidthUp",
      "NoNeckPainWidthDown",
      "NoNeckPainScratchPad",
    },
    opts = {
      width = 130,
      buffers = {
        colors = {
          background = require("catppuccin.palettes").get_palette().crust,
        },
      },
    },
  },
}
